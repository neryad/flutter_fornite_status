// import 'package:flutter/material.dart';

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           _buildHeaderSection(),
//           _buildTabBar(),
//           _buildStatsSection(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderSection() {
//     return SliverAppBar(
//       expandedHeight: 250.0,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Stack(
//           children: [
//             // Background Image
//             Positioned.fill(
//               child: Image.asset(
//                 'assets/background.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             // Purple Overlay
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.purple.withOpacity(0.8),
//                       Colors.black.withOpacity(0.4),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//             ),
//             // Content
//             Positioned(
//               bottom: 20.0,
//               left: 16.0,
//               right: 16.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'NINJA',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.circle, color: Colors.green, size: 12),
//                       SizedBox(width: 8),
//                       Text(
//                         'In solo match',
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                       Spacer(),
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                         ),
//                         child: Text(
//                           'FOLLOWING',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return SliverToBoxAdapter(
//       child: DefaultTabController(
//         length: 2,
//         child: Column(
//           children: [
//             TabBar(
//               tabs: [
//                 Tab(text: 'SEASON 3'),
//                 Tab(text: 'LIFETIME'),
//               ],
//               indicatorColor: Colors.green,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white70,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatsSection() {
//     final stats = [
//       {
//         'title': 'SOLO',
//         'score': '369,880',
//         'kills': '8,000',
//         'games': '808',
//         'wins': '404',
//         'kdr': '12.54',
//         'winRate': '50.0%',
//         'rank': '#1,405',
//       },
//       {
//         'title': 'DUOS',
//         'score': '447,340',
//         'kills': '7,160',
//         'games': '912',
//         'wins': '465',
//         'kdr': '15.71',
//         'winRate': '50.5%',
//         'rank': '#531',
//       },
//       {
//         'title': 'SQUADS',
//         'score': '157,470',
//         'kills': '2,700',
//         'games': '431',
//         'wins': '110',
//         'kdr': '8.91',
//         'winRate': '26.6%',
//         'rank': '#3,571',
//       },
//     ];

//     return SliverToBoxAdapter(
//       child: Column(
//         children: stats.map((stat) {
//           return Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Card(
//               color: Colors.white.withOpacity(0.1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           stat['title']!,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         Text(
//                           stat['rank']!,
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     GridView.count(
//                       shrinkWrap: true,
//                       crossAxisCount: 3,
//                       physics: NeverScrollableScrollPhysics(),
//                       childAspectRatio: 2.5,
//                       children: [
//                         _buildStatTile('Score', stat['score']!),
//                         _buildStatTile('Kills', stat['kills']!),
//                         _buildStatTile('Games Played', stat['games']!),
//                         _buildStatTile('Wins', stat['wins']!),
//                         _buildStatTile('K/D', stat['kdr']!),
//                         _buildStatTile('Win %', stat['winRate']!),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildStatTile(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white70,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Map<String, dynamic>? stats;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    try {
      final data = await fetchFortniteStats(
          'SrKevs'); // Reemplaza 'username' con el nombre de usuario real
      setState(() {
        stats = data[
            'data']; // Asegúrate de acceder a la clave correcta en la respuesta
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching stats: $e';
      });
      print('Error fetching stats: $e');
    }
  }

  Future<Map<String, dynamic>> fetchFortniteStats(String username) async {
    final dio = Dio();
    final url = 'https://fortnite-api.com/v2/stats/br/v2?name=$username';

    String envValue = dotenv.env['TOKEN'] ?? 'default_value';

    try {
      final response = await dio.get(url,
          options: Options(headers: {'Authorization': envValue}));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load stats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (stats == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeaderSection(),
          _buildTabBar(),
          _buildStatsSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Purple Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withOpacity(0.8),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 20.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NINJA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 12),
                      SizedBox(width: 8),
                      Text(
                        'In solo match',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          'FOLLOWING',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'SEASON 3'),
                Tab(text: 'LIFETIME'),
              ],
              indicatorColor: Colors.green,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    final statsList = [
      {
        'title': 'SOLO',
        'score': stats!['solo']['score'].toString(),
        'kills': stats!['solo']['kills'].toString(),
        'games': stats!['solo']['games'].toString(),
        'wins': stats!['solo']['wins'].toString(),
        'kdr': stats!['solo']['kd'].toString(),
        'winRate': stats!['solo']['winRate'].toString(),
        'rank': stats!['solo']['rank'].toString(),
      },
      {
        'title': 'DUOS',
        'score': stats!['duo']['score'].toString(),
        'kills': stats!['duo']['kills'].toString(),
        'games': stats!['duo']['games'].toString(),
        'wins': stats!['duo']['wins'].toString(),
        'kdr': stats!['duo']['kd'].toString(),
        'winRate': stats!['duo']['winRate'].toString(),
        'rank': stats!['duo']['rank'].toString(),
      },
      {
        'title': 'SQUADS',
        'score': stats!['squad']['score'].toString(),
        'kills': stats!['squad']['kills'].toString(),
        'games': stats!['squad']['games'].toString(),
        'wins': stats!['squad']['wins'].toString(),
        'kdr': stats!['squad']['kd'].toString(),
        'winRate': stats!['squad']['winRate'].toString(),
        'rank': stats!['squad']['rank'].toString(),
      },
    ];

    return SliverToBoxAdapter(
      child: Column(
        children: statsList.map((stat) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stat['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          stat['rank']!,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.5,
                      children: [
                        _buildStatTile('Score', stat['score']!),
                        _buildStatTile('Kills', stat['kills']!),
                        _buildStatTile('Games Played', stat['games']!),
                        _buildStatTile('Wins', stat['wins']!),
                        _buildStatTile('K/D', stat['kdr']!),
                        _buildStatTile('Win %', stat['winRate']!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
