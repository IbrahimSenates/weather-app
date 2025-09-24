import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class MainInfo extends StatelessWidget {
  final List<WeatherModel> weatherData;
  late String city;
  MainInfo({super.key, required this.weatherData, required this.city});

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 98,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 183,
        child: Column(
          children: [
            Text(
              city = city.toString(),
              style: TextStyle(
                fontSize: 36,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              weatherData.isNotEmpty
                  ? weatherData[0].degree.toString() + '°C'
                  : 'Yükleniyor',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              weatherData.isNotEmpty
                  ? _capitalize(weatherData[0].generalStatus)
                  : 'Yükleniyor',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFEEEEEE),
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherData.isNotEmpty
                      ? 'H:' + weatherData[0].tempMax.toString() + '°'
                      : 'Yükleniyor',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  weatherData.isNotEmpty
                      ? 'L:' + weatherData[0].tempMin.toString() + '°'
                      : 'Yükleniyor',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
