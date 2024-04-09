import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherServices = WeatherServices('a7f33965d7c33afe3a6de8be0788a3cd');

  WeatherModel? _weatherModel;

  _fetchWeather() async {
    String cityName = await _weatherServices.getCurrentLocation();

    try {
      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    } else {
      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'fog':
        case 'haze':
        case 'dust':
          return 'assets/cloudy.json';
        case 'rain':
        case 'shower rain':
          return 'assets/thunderWithRain.json';
        case 'drizzle':
          return 'assets/rainingWithSun.json';
        case 'clear':
          return 'assets/sunny.json';
        case 'few clouds':
          return 'assets/partiallyCloudy.json';
        default:
          return 'assets/sunny.json';
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    int? dispTemperature = _weatherModel?.temperature.round();
    int displayTemperature = 0;
    if (dispTemperature == null) {
      displayTemperature = 0;
    } else {
      displayTemperature = dispTemperature - 273;
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weatherModel?.cityName ?? "Loading...",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset(
              getAnimation(_weatherModel?.mainCondition),
            ),
            Text(
              '$displayTemperature°C',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              _weatherModel?.mainCondition ?? "",
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              _weatherModel?.description ?? "",
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Feels like : ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          findTemperatre(_weatherModel?.feelsLike),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Minimum temperature: ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          findTemperatre(
                            _weatherModel?.minTemperature,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Maximum temperature: ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          findTemperatre(
                            _weatherModel?.maxTemperature,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String findTemperatre(double? feelsLike) {
    int calcTemperature = 0;
    int? calcTemp = feelsLike?.round();
    if (calcTemp == null) {
      calcTemperature = 0;
    } else {
      calcTemperature = calcTemp - 273;
    }
    return '$calcTemperature°C';
  }
}
