import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/detail_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<WeatherModel> weatherData;
  final String city;
  const HomeScreen({super.key, required this.city, required this.weatherData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WeatherModel> _weather = [];
  late String city;
  bool _showHourly = true;
  bool _showWeekly = false;

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _getHourlyForecast() {
    if (_showHourly == false) {
      setState(() {
        _showHourly = !_showHourly;
        _showWeekly = !_showWeekly;
      });
    }
  }

  void _getWeeklyForecast() {
    if (_showWeekly == false) {
      setState(() {
        _showWeekly = !_showWeekly;
        _showHourly = !_showHourly;
      });
    }
  }

  @override
  void initState() {
    _weather = widget.weatherData;
    city = widget.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/background2.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          _mainInfo(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 390,
              decoration: BoxDecoration(
                color: Color(0xFF2E335A),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          if (_showHourly) _bottomHourlyInfo(),
          if (_showWeekly) _bottomWeeklyInfo(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset("assets/images/TabBar.png", fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 330,
            child: TextButton(
              onPressed: () => _getHourlyForecast(),
              child: Text(
                'Saatlik ',
                style: TextStyle(
                  color: _showHourly ? Colors.white : Colors.grey,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 330,
            child: TextButton(
              onPressed: () => _getWeeklyForecast(),
              child: Text(
                'Haftalık',
                style: TextStyle(
                  color: _showWeekly ? Colors.white : Colors.grey,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 330,
            child: Container(height: 2, color: Colors.grey.shade500),
          ),
          Positioned(
            bottom: 25,
            right: 35,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(data: _weather),
                ),
              ),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 35,
            child: GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false,
              ),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _bottomHourlyInfo() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 10),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (context, index) {
            if (index < _weather.length) {
              final weather = _weather[index];
              final icon = _weather[index].icon;
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
                  subtitle: Container(
                    height: 160,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/$icon@2x.png',
                          color: _weather[index].generalStatus == 'açık'
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

  Positioned _mainInfo() {
    return Positioned(
      top: 98,
      left: 0,
      right: 0,
      child: Container(
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
              _weather.isNotEmpty
                  ? _weather[0].degree.toString() + '°C'
                  : 'Yükleniyor',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _weather.isNotEmpty
                  ? _capitalize(_weather[0].generalStatus)
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
                  _weather.isNotEmpty
                      ? 'H:' + _weather[0].tempMax.toString() + '°'
                      : 'Yükleniyor',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  _weather.isNotEmpty
                      ? 'L:' + _weather[0].tempMin.toString() + '°'
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

  Positioned _bottomWeeklyInfo() {
    final List<WeatherModel> weeklyForecast = _weather
        .where((weather) => weather.date.hour == 12)
        .toList();

    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 10),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: weeklyForecast.length,
          itemBuilder: (context, index) {
            if (index < _weather.length) {
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
                  subtitle: Container(
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
