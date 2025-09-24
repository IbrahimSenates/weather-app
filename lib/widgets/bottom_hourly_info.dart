import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class BottomHourlyInfo extends StatelessWidget {
  final List<WeatherModel> weatherData;

  const BottomHourlyInfo({super.key, required this.weatherData});

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 10),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (context, index) {
            if (index < weatherData.length) {
              final weather = weatherData[index];
              final icon = weatherData[index].icon;
              return Container(
                width: 120,

                decoration: BoxDecoration(
                  color: const Color(0xFF48319D),

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                    bottom: Radius.circular(30),
                  ),
                ),
                margin: EdgeInsets.only(right: 13),
                child: ListTile(
                  title: Text(
                    '${weather.date.hour.toString().padLeft(2, '0')}:00 ',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: SizedBox(
                    height: 160,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/$icon@2x.png',
                          color: weatherData[index].generalStatus == 'açık'
                              ? Colors.yellow
                              : null,
                        ),
                        Text(
                          _capitalize(weather.generalStatus),
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        Text(
                          '${weather.degree}°C',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
