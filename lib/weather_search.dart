import 'package:flutter/material.dart';
import 'package:weatherapp/api/api_error.dart';
import 'package:weatherapp/api/api_service.dart';
import 'package:weatherapp/models/weather_data.dart';

import 'utils.dart';

class WeatherSearch extends StatefulWidget {
  const WeatherSearch({Key? key}) : super(key: key);

  @override
  _WeatherSearchState createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  //final _location = LocationData();
  final _weather = ApiService();
  late TextEditingController searchController;
  String? search;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: "");
    searchController.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //("Building WeatherSearchState");
    var edgeInsets = const EdgeInsets.symmetric(vertical: 16.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: Container(
        padding: edgeInsets,
        alignment: Alignment.center,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Input the name city here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: const Icon(Icons.search),
                ),
                controller: searchController,
                onSubmitted: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
            search == null
                ? Container()
                : FutureBuilder<WeatherData>(
                    future: _weather.getWeather(search!),
                    builder: (context, snapshot) {
                      if (snapshot.error != null) {
                        if (snapshot.error is ApiServiceError) {
                          final response =
                              (snapshot.error as ApiServiceError).response;
                          return Center(
                              child: Text('Request failed: ${response.body}'));
                        }
                        return Center(
                            child: Text(
                                'Something went wrong: ${snapshot.error.toString()}'));
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      WeatherData weather = snapshot.data!;
                      return Column(
                        children: [
                          Text(
                            weather.name,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "${(convertKelvinToCelcius(weather.main.temp)).toStringAsFixed(2)}°C",
                            style: const TextStyle(
                              fontSize: 80,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ...weather.weather.map(
                            (e) => Text(
                              '${e.main}: ${e.description}',
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
