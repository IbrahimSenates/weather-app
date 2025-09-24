import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/detail_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/widgets/bottom_hourly_info.dart';
import 'package:weather_app/widgets/bottom_weekly_info.dart';
import 'package:weather_app/widgets/main_info.dart';

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
          MainInfo(weatherData: _weather, city: city),
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
          if (_showHourly) BottomHourlyInfo(weatherData: _weather),
          if (_showWeekly) BottomWeeklyInfo(weatherData: _weather),
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
}
