import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart' as k;
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/size.dart';

import '../utils/container_box_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  num? temp;
  num? press;
  num? hum;
  num? cover;
  String? cityname;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: AppScreen.width(80),
                    height: AppScreen.height(5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.search,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TextFormField(
                        onFieldSubmitted: (String search) {
                          setState(() {
                            cityname = search;
                            getCityWeather(search);
                            controller.clear();
                          });
                        },
                        controller: controller,
                        cursorColor: AppColors.dark,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark),
                        decoration: InputDecoration(
                          hintText: 'Search city',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: AppColors.dark.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 25,
                            color: AppColors.dark.withOpacity(0.7),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Visibility(
                    visible: cityname != null,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.primary,
                                  size: 40,
                                ),
                                Text(
                                  cityname ?? 'search location',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          WeatherDataTable(
                            temperature: temp?.toInt(),
                            pressure: press?.toInt(),
                            humidity: hum?.toInt(),
                            cloudCover: cover?.toInt(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: cityname == null,
                    child: const Center(
                      child: Text('Search for the location'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temp = 0;
        press = 0;
        hum = 0;
        cover = 0;
        cityname = 'N/A';
      } else {
        temp = decodedData['main']['temp'] - 273;
        press = decodedData['main']['pressure'];
        hum = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
    });
  }

  getCityWeather(String cityname) async {
    var client = http.Client();
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      updateUI(decodeData);
    }
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      updateUI(decodeData);
    }
  }
}
