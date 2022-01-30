import 'dart:convert';
import 'package:http/http.dart' as http;

class Worker {
  late String location;

  Worker({required this.location}) {
    location = this.location;
  }
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  //method

  Future<void> getData() async {
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=c14287809f7ef2c5f1639b25705818e9');
      var response = await http.get(url);
      Map data = jsonDecode(response.body);

      // Getting Temp, Humidity

      Map temp_data = data['main'];
      double gettemp = temp_data['temp'] - 273.15;
      String gethumidity = temp_data['humidity'].toString();

      // getting Air Speed
      Map wind = data['wind'];
      double getair_speed = wind["speed"] / 0.277778;

      //Getting Description

      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];
      icon = weather_main_data['icon'].toString();

      // Assigning Values

      temp = gettemp.toString();
      humidity = gethumidity;
      air_speed = getair_speed.toString();
      description = getdesc;
      main = getmain_des;
    } catch (e) {
      temp = "N/A";
      humidity = "N/A";
      air_speed = "N/A";
      description = "cant't find data";
      main = "N/A";
      icon = "09d";
    }
  }
}
