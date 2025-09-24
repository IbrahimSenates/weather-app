import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class BottomWeeklyInfo extends StatelessWidget {
  final List<WeatherModel> weatherData;

  const BottomWeeklyInfo({super.key, required this.weatherData});

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  List<WeatherModel> get weeklyForecast {
    return weatherData.where((weather) => weather.date.hour == 12).toList();
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
          itemCount: weeklyForecast.length,
          itemBuilder: (context, index) {
            if (index < weatherData.length) {
              final weather = weeklyForecast[index];
              final icon = weather.icon;

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
                    getWeekdayName(weather.date.weekday),
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: SizedBox(
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/$icon@2x.png',
                          color: weather.generalStatus == 'açık'
                              ? Colors.yellow
                              : null,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            _capitalize(weather.generalStatus),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
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

  String getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Pazartesi';
      case 2:
        return 'Salı';
      case 3:
        return 'Çarşamba';
      case 4:
        return 'Perşembe';
      case 5:
        return 'Cuma';
      case 6:
        return 'Cumartesi';
      case 7:
        return 'Pazar';
      default:
        return '';
    }
  }
}
