import 'package:http/http.dart' as http;

getWeather({latitude, longitude}) async {
  const String apiKey = "0e16c1797945f354f8e9054f92c5ffd1";

  String link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey";

  var url = Uri.parse(link);

  var response = await http.get(url);

  return response.body;
}