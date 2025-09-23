import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  Future<String> getLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Konum servisi kapalı");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Konum izni veriniz");
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    final List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final String? city = placemark[0].administrativeArea;
    if (city == null) throw Exception("Şehir bulunamadı");

    return city;
  }

  Future getWeatherData() async {
    await dotenv.load();
    final String city = await getLocation();

    final apiKey = dotenv.env['API_KEY'];
    final String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric&lang=tr";

    final dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }

    final List list = response.data['list'];
    final List<WeatherModel> weatherList = list
        .map((e) => WeatherModel.fromJson(e))
        .toList();

    return weatherList;
  }
}
