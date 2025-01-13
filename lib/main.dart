import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fornite_status/map.dart';
import 'package:flutter_fornite_status/models/shop_model.dart';
import 'package:flutter_fornite_status/test.dart';

class FortniteStatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortnite Stats Viewer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        hintColor: Colors.amber,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    StatsScreen(),
    //MyWidget(),
    MapScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fortnite Stats Viewer'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late Future<Map<String, dynamic>> futureStats;
  final TextEditingController _usernameController = TextEditingController();

  void fetchStats() {
    setState(() {
      futureStats = fetchFortniteStats(_usernameController.text);
    });
  }

  Future<Map<String, dynamic>> fetchFortniteStats(String username) async {
    final dio = Dio();
    final url = 'https://fortnite-api.com/v2/stats/br/v2?name=$username';

    String envValue = dotenv.env['TOKEN'] ?? 'default_value';

    try {
      final response = await dio.get(url,
          options: Options(headers: {'Authorization': envValue}));
      return response.data;
    } catch (e) {
      throw Exception('Failed to load stats: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _usernameController.text = "SrKevs";
    fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "Enter Fortnite username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: fetchStats,
                  child: Text("Search"),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: futureStats,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return StatsPage(stats: snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StatsPage extends StatelessWidget {
  final Map<String, dynamic> stats;

  const StatsPage({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final battlePass = stats['data']['battlePass'];
    final overallStats = stats['data']['stats']['all']['overall'];
    final soloStats = stats['data']['stats']['all']['solo'];
    final duoStats = stats['data']['stats']['all']['duo'];
    final squadStats = stats['data']['stats']['all']['squad'];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                constraints.maxWidth > 600
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildBattlePassCard(battlePass)),
                          SizedBox(width: 16),
                          Expanded(child: _buildOverallStatsCard(overallStats)),
                        ],
                      )
                    : Column(
                        children: [
                          _buildBattlePassCard(battlePass),
                          SizedBox(height: 16),
                          _buildOverallStatsCard(overallStats),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    _buildModeStatsCard("Solo Stats", soloStats),
                    SizedBox(height: 16),
                    _buildModeStatsCard("Duo Stats", duoStats),
                    SizedBox(height: 16),
                    _buildModeStatsCard("Squad Stats", squadStats),
                  ],
                ),
                SizedBox(height: 16),
                _buildPieChart(stats['data']['stats']['all']),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBattlePassCard(Map<String, dynamic> battlePass) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.military_tech, color: Colors.amber, size: 28),
                SizedBox(width: 8),
                Text(
                  "Battle Pass",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Level: ${battlePass['level']}",
                style: TextStyle(fontSize: 16)),
            LinearProgressIndicator(
              value: battlePass['progress'] / 100,
              color: Colors.amber,
              backgroundColor: Colors.purple[700],
            ),
            SizedBox(height: 8),
            Text("${battlePass['progress']}% completed",
                style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallStatsCard(Map<String, dynamic> overallStats) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Overall Stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Wins: ${overallStats['wins']}"),
            Text("Kills: ${overallStats['kills']}"),
            Text("K/D: ${overallStats['kd']}"),
            Text("Minutes Played: ${overallStats['minutesPlayed']}"),
          ],
        ),
      ),
    );
  }

  Widget _buildModeStatsCard(String title, Map<String, dynamic> modeStats) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Wins: ${modeStats['wins']}"),
            Text("Kills: ${modeStats['kills']}"),
            Text("K/D: ${modeStats['kd']}"),
            Text("Matches: ${modeStats['matches']}"),
            Text("Minutes Played: ${modeStats['minutesPlayed']}"),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, dynamic> stats) {
    final killsByMode = {
      "Solo": stats['solo']['kills'],
      "Duo": stats['duo']['kills'],
      "Squad": stats['squad']['kills'],
    };

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kills by Mode",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: killsByMode.entries.map((entry) {
                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: entry.key,
                      color: Colors.primaries[
                          killsByMode.keys.toList().indexOf(entry.key) %
                              Colors.primaries.length],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future main() async {
  // Cargar variables de entorno solo en desarrollo
  if (!const bool.fromEnvironment('dart.vm.product')) {
    await dotenv.load(fileName: ".env");
  }
  runApp(FortniteStatsApp());
}
