class WeatherModel {
  final double degree;
  final double tempMax;
  final double tempMin;
  final String generalStatus;
  final DateTime date;
  final String icon;
  final double humidity;
  final double feelsLike;
  final double wind;

  WeatherModel({
    required this.degree,
    required this.tempMax,
    required this.tempMin,
    required this.generalStatus,
    required this.date,
    required this.icon,
    required this.humidity,
    required this.feelsLike,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      degree: (json['main']['temp'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      generalStatus: json['weather'][0]['description'],
      date: DateTime.parse(json['dt_txt']),
      icon: json['weather'][0]['icon'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      wind: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
