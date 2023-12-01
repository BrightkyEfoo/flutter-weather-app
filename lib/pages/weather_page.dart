import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:helloapp/models/weather_model.dart";
import "package:helloapp/services/weather_service.dart";

class WheatherPage extends StatefulWidget {
  const WheatherPage({super.key});

  @override
  State<WheatherPage> createState() => _WheatherPageState();
}

class _WheatherPageState extends State<WheatherPage> {
  final _weatherService = WeatherService("9c454fae663a76c8d2b23e531f828d6c");
  Weather? _weather;
  String getWeatherAnimation (String? mainCondition){
    if(mainCondition == null){
      return 'assets/sunny.json';
    }

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default : 
        return 'assets/sunny.json';
    }
  }
  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_weather?.cityName ?? "loading city..."),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          Text('${_weather?.temperature.round()}°C'),
          Text(_weather?.mainCondition ?? "")
        ],
      ),
    ));
  }
}
