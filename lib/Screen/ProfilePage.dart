import 'package:appspertanian/Form/Log1.dart';
import 'package:appspertanian/Screen/WeatherPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = 'Memuat...';
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoadingWeather = true;
  String? _weatherError;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([_loadUserEmail(), _fetchWeatherForDefaultLocation()]);
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _email = prefs.getString('last_user_email') ?? 'Email tidak ditemukan';
      });
    }
  }

  Future<void> _fetchWeatherForDefaultLocation() async {
    setState(() {
      _isLoadingWeather = true;
      _weatherError = null;
    });
    try {
      final weather = await _weatherService.fetchWeather('Denpasar');
      if (mounted) {
        setState(() {
          _weather = weather;
          _isLoadingWeather = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _weatherError = e.toString().replaceFirst('Exception: ', '');
          _isLoadingWeather = false;
        });
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Log1()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Pengguna',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF14A741),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 100, color: Colors.grey),
              const SizedBox(height: 20),
              Text(
                'Selamat Datang',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _email,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              _buildWeatherCard(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: Text(
                  'Logout',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14A741),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    if (_isLoadingWeather) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(strokeWidth: 2.0),
              SizedBox(width: 16),
              Text('Memuat info cuaca...'),
            ],
          ),
        ),
      );
    }

    if (_weatherError != null) {
      return Card(
        color: Colors.red.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Text(_weatherError!, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      );
    }

    if (_weather != null) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    _weather!.cityName,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_weather!.temperature.toStringAsFixed(1)}°C',
                    style: GoogleFonts.roboto(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  _getWeatherIconWidget(_weather!.description),
                  Text(
                    _weather!.description,
                    style: GoogleFonts.poppins(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _getWeatherIconWidget(String description) {
    String desc = description.toLowerCase();
    IconData iconData;
    Color iconColor;

    if (desc.contains('cerah berawan')) {
      iconData = Icons.wb_cloudy;
      iconColor = Colors.yellow.shade700;
    } else if (desc.contains('cerah')) {
      iconData = Icons.wb_sunny;
      iconColor = Colors.orange;
    } else if (desc.contains('berawan')) {
      iconData = Icons.cloud;
      iconColor = Colors.grey.shade600;
    } else if (desc.contains('hujan petir') || desc.contains('badai')) {
      iconData = Icons.thunderstorm;
      iconColor = Colors.deepPurple;
    } else if (desc.contains('hujan')) {
      iconData = Icons.water_drop;
      iconColor = Colors.blue;
    } else if (desc.contains('kabut')) {
      iconData = Icons.dehaze;
      iconColor = Colors.blueGrey;
    } else if (desc.contains('salju')) {
      iconData = Icons.ac_unit;
      iconColor = Colors.lightBlueAccent;
    } else {
      iconData = Icons.thermostat;
      iconColor = Colors.grey;
    }
    return Icon(iconData, size: 50, color: iconColor);
  }
}
