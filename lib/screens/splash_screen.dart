import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/weather_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    try {
      final weatherService = WeatherService();
      final weatherData = await weatherService.getWeatherData();
      final city = await weatherService.getLocation();

      // Navigasyona geçmeden önce biraz bekle (isteğe bağlı)
      await Future.delayed(Duration(seconds: 2));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(weatherData: weatherData, city: city),
        ),
      );
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3C467B),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: Lottie.asset('assets/animations/splash_screen_animation.json'),
        ),
      ),
    );
  }
}
