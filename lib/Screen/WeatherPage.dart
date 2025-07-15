import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  final String _apiKey = 'ed1383791b9ea04391f8709b552bfe80';

  Future<Weather> fetchWeather(String cityName) async {
    final uri = Uri.parse(
      '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric&lang=id',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      String errorMessage;
      try {
        final errorBody = jsonDecode(response.body);

        errorMessage =
            (errorBody['message'] as String?)?.replaceAll(
              'city not found',
              'Kota tidak ditemukan',
            ) ??
            'Terjadi error tidak diketahui.';
      } catch (e) {
        errorMessage =
            'Error: Gagal terhubung ke server (Status code: ${response.statusCode})';
      }
      throw Exception(errorMessage);
    }
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();

  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  void _fetchWeather() async {
    if (_cityController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Silakan masukkan nama kota.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _weather = null;
    });

    try {
      final weather = await _weatherService.fetchWeather(_cityController.text);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cek Cuaca',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF14A741),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Kota',
                hintText: 'Contoh: Jakarta',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
              onSubmitted: (_) => _fetchWeather(),
            ),
            const SizedBox(height: 20),

            // Tampilan hasil
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              )
            else if (_weather != null)
              _buildWeatherInfo(_weather!)
            else
              const Text('Masukkan nama kota untuk melihat cuaca.'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(Weather weather) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Image.network(
          'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
        Text(
          '${weather.temperature.toStringAsFixed(1)}°C',
          style: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w300),
        ),
        Text(
          weather.description,
          style: GoogleFonts.poppins(fontSize: 20, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
