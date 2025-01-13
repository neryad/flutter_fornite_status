import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<MapData> futureMapData;
  String? highlightedPoiId;

  @override
  void initState() {
    super.initState();
    futureMapData = fetchMapData();
  }

  Future<MapData> fetchMapData() async {
    final dio = Dio();
    final url = 'https://fortnite-api.com/v1/map';

    try {
      final response = await dio.get(url);
      return MapData.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to load map data: $e');
    }
  }

  void highlightPoi(String poiId) {
    setState(() {
      highlightedPoiId = poiId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fortnite Map'),
      ),
      body: FutureBuilder<MapData>(
        future: futureMapData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final mapData = snapshot.data!;
            return Stack(
              children: [
                Image.network(mapData.images['pois'] ?? ''),
                ...mapData.pois.map((poi) {
                  return Positioned(
                    left: (poi.location['x'].toDouble() + 100) /
                        200, // Adjust position scaling
                    top: (poi.location['y'].toDouble() + 100) /
                        200, // Adjust position scaling
                    child: GestureDetector(
                      onTap: () => highlightPoi(poi.id),
                      child: Container(
                        width: 40, // Increase size for better visibility
                        height: 40, // Increase size for better visibility
                        decoration: BoxDecoration(
                          color: highlightedPoiId == poi.id
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          border: highlightedPoiId == poi.id
                              ? Border.all(color: Colors.yellow, width: 2)
                              : null,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: mapData.pois.length,
                        itemBuilder: (context, index) {
                          final poi = mapData.pois[index];
                          return ListTile(
                            title: Text(poi.name),
                            subtitle: Text(
                                'Location: (${poi.location['x']}, ${poi.location['y']}, ${poi.location['z']})'),
                            onTap: () => highlightPoi(poi.id),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class MapData {
  final Map<String, String> images;
  final List<Poi> pois;

  MapData({required this.images, required this.pois});

  factory MapData.fromJson(Map<String, dynamic> json) {
    var poisJson = json['pois'] as List;
    List<Poi> poisList = poisJson.map((i) => Poi.fromJson(i)).toList();

    return MapData(
      images: Map<String, String>.from(json['images']),
      pois: poisList,
    );
  }
}

class Poi {
  final String id;
  final String name;
  final Map<String, dynamic> location;

  Poi({required this.id, required this.name, required this.location});

  factory Poi.fromJson(Map<String, dynamic> json) {
    return Poi(
      id: json['id'],
      name: json['name'],
      location: Map<String, dynamic>.from(json['location']),
    );
  }
}
