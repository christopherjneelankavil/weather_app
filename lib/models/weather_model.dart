class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      feelsLike: json['main']['feels_like'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      maxTemperature: json['main']['temp_max'].toDouble(),
    );
  }
}

