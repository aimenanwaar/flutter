import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Position? currentPosition;
  String? str = "";

  getCurrentLocation() async {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true
    ).then((Position position){
      setState(() {
        currentPosition = position;
      });
    }).catchError((e){
      print(e);
    });
  }

  Map<String, dynamic>? str1;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Flutter API Project',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Project'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(currentPosition != null ) Text(
                  "LONGITUDE: ${currentPosition!.longitude}"
              ),
              const SizedBox(
                height: 5,
              ),
              if(currentPosition != null ) Text(
                  "LATITUDE: ${currentPosition!.latitude}"
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () async {
                  currentPosition = getCurrentLocation();
                },
                child: const Text('Get Location'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  primary: Colors.white,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if(str1 != null ) Text(
                'City: ${str1!['name']}',
              ),
              const SizedBox(
                height: 5,
              ),
              if(str1 != null ) Text(
                'Temp: ${str1!['main']['temp']} °C',
              ),
              const SizedBox(
                height: 5,
              ),
              if(str1 != null ) Text(
                'Feels Like: ${str1!['main']['feels_like']} °C',
              ),
              const SizedBox(
                height: 5,
              ),
              if(str1 != null ) Text(
                'Min Temp: ${str1!['main']['temp_min']} °C',
              ),
              const SizedBox(
                height: 5,
              ),
              if(str1 != null ) Text(
                'Max Temp: ${str1!['main']['temp_max']} °C',
              ),
              const SizedBox(
                height: 5,
              ),
              if(str1 != null ) Text(
                'Visibility: ${str1!['visibility']}',
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  str = await getWeather(longitude: currentPosition!.longitude, latitude: currentPosition!.latitude);
                  str1 = jsonDecode(str!);
                  setState(() { });
                },
                child: const Text('Get Weather'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  primary: Colors.white,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
