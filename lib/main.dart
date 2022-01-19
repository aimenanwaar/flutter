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
      theme: ThemeData(
        // backgroundColor: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 15,
          centerTitle: true,
        ),
      ),
      title: 'Flutter API Project',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Project'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      currentPosition = getCurrentLocation();
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.add_location),
                        SizedBox(width: 10,),
                        Text('Get Location'),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      str = await getWeather(longitude: currentPosition!.longitude, latitude: currentPosition!.latitude);
                      str1 = jsonDecode(str!);
                      setState(() { });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.cloud),
                        SizedBox(width: 10,),
                        Text('Get Weather'),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  if(currentPosition != null ) const SizedBox(
                    height: 10,
                  ),
                  if(currentPosition != null ) Text(
                    "LONGITUDE: ${currentPosition!.longitude}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if(currentPosition != null ) const SizedBox(
                    height: 5,
                  ),
                  if(currentPosition != null ) Text(
                    "LATITUDE: ${currentPosition!.latitude}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  if(str1 != null ) const SizedBox(
                    height: 10,
                  ),
                  if(str1 != null ) Text(
                    'Current weather in ${str1!['name']} is: ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if(str1 != null ) const SizedBox(
                    height: 5,
                  ),
                  if(str1 != null ) Text(
                    '${str1!['main']['temp']} °C',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if(str1 != null ) const SizedBox(
                    height: 10,
                  ),
                  if(str1 != null ) Text(
                    'Feels Like: ${str1!['main']['feels_like']} °C',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if(str1 != null ) const SizedBox(
                    height: 5,
                  ),
                  if(str1 != null ) Text(
                    'Description: ${str1!['weather'][0]['description']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if(str1 != null ) const SizedBox(
                    height: 5,
                  ),
                  if(str1 != null ) Text(
                    'Visibility: ${str1!['visibility']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
