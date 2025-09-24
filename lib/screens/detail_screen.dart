import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class DetailScreen extends StatelessWidget {
  final List<WeatherModel> data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<WeatherModel> weeklyForecast = data
        .where((weather) => weather.date.hour == 12)
        .toList();
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF362A84)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final widhtScreen = constraints.maxWidth;
          final itemHeight = constraints.maxHeight * 0.30;
          return Container(
            color: Color(0xFF2E335A),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: widhtScreen * 0.05),
              itemCount: weeklyForecast.length,
              itemBuilder: (context, index) {
                final icon = weeklyForecast[index].icon;

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/rectAngle.png'),
                      fit: BoxFit.contain,
                    ),
                  ),

                  padding: EdgeInsets.only(left: 15),
                  width: widhtScreen,

                  height: itemHeight,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getWeekdayName(
                                  weeklyForecast[index].date.weekday,
                                ),
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${weeklyForecast[index].degree.toInt().toString()}°',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: itemHeight * 0.3,
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                            'https://openweathermap.org/img/wn/$icon@2x.png',
                            fit: BoxFit.fill,
                            scale: 0.7,
                            color: weeklyForecast[index].generalStatus == 'açık'
                                ? Colors.yellow
                                : null,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            'H:${weeklyForecast[index].tempMax.toInt().toString()}°C',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          SizedBox(width: 10),

                          Text(
                            'L:${weeklyForecast[index].tempMin.toInt().toString()}°C',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(
                        width: widhtScreen * 0.8,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rüzgar Hızı: ${weeklyForecast[index].wind.toString()}',
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            Text(
                              'Nem:${weeklyForecast[index].humidity.toString()}',
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Hissedilen:${weeklyForecast[index].feelsLike.toInt().toString()}°',
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
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
