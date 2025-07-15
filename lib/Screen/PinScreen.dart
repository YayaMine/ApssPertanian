import 'dart:async';
import 'dart:convert';

import 'package:appspertanian/Screen/mainpage.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PinScreenMode { create, confirm, enter }

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  PinScreenMode _mode = PinScreenMode.enter;
  String _enteredPin = '';
  String _tempPin = '';
  String _title = 'Masukkan PIN Anda';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPinStatus();
  }

  Future<void> _checkPinStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final pinHash = prefs.getString('user_pin_hash');
    if (!mounted) return;

    if (pinHash == null) {
      setState(() {
        _mode = PinScreenMode.create;
        _title = 'Buat PIN Keamanan (6 Digit)';
        _isLoading = false;
      });
    } else {
      setState(() {
        _mode = PinScreenMode.enter;
        _title = 'Masukkan PIN Anda';
        _isLoading = false;
      });
    }
  }

  void _onNumberPressed(String value) {
    if (_enteredPin.length < 6) {
      setState(() {
        _enteredPin += value;
      });
      if (_enteredPin.length == 6) {
        _processPin();
      }
    }
  }

  void _onDeletePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
        ),
      );
    }
  }

  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  Future<void> _processPin() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    switch (_mode) {
      case PinScreenMode.create:
        setState(() {
          _tempPin = _enteredPin;
          _enteredPin = '';
          _mode = PinScreenMode.confirm;
          _title = 'Konfirmasi PIN Anda';
        });
        break;
      case PinScreenMode.confirm:
        if (_enteredPin == _tempPin) {
          final prefs = await SharedPreferences.getInstance();
          final pinHash = _hashPin(_enteredPin);
          await prefs.setString('user_pin_hash', pinHash);
          _showSnackBar('PIN berhasil dibuat!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        } else {
          _showSnackBar('PIN tidak cocok. Silakan coba lagi.', isError: true);
          setState(() {
            _enteredPin = '';
            _tempPin = '';
            _mode = PinScreenMode.create;
            _title = 'Buat PIN Keamanan (6 Digit)';
          });
        }
        break;
      case PinScreenMode.enter:
        final prefs = await SharedPreferences.getInstance();
        final storedHash = prefs.getString('user_pin_hash');
        final enteredPinHash = _hashPin(_enteredPin);

        if (storedHash == enteredPinHash) {
          _showSnackBar('PIN Benar!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        } else {
          _showSnackBar('PIN Salah.', isError: true);
          setState(() {
            _enteredPin = '';
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    final titleFontSize = isTablet ? 36.0 : 22.0;
    final numpadFontSize = isTablet ? 48.0 : 32.0;
    final iconSize = isTablet ? 40.0 : 30.0;
    final dotSize = isTablet ? 25.0 : 20.0;
    final dotMargin = isTablet ? 15.0 : 10.0;

    final numpadVerticalPadding = isTablet ? screenHeight * 0.05 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFF14A741),
      resizeToAvoidBottomInset: false,
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
              : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: isTablet ? 80 : 50),
                      Text(
                        _title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: dotMargin),
                            width: dotSize,
                            height: dotSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  index < _enteredPin.length
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: numpadVerticalPadding),
                      _buildNumpad(numpadFontSize, iconSize),
                      SizedBox(height: numpadVerticalPadding),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildNumpad(double numpadFontSize, double iconSize) {
    final numbers = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'del'],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.8 : 1.2,
        children:
            numbers
                .expand((row) => row)
                .map(
                  (value) =>
                      _buildNumpadButton(value, numpadFontSize, iconSize),
                )
                .toList(),
      ),
    );
  }

  Widget _buildNumpadButton(String value, double fontSize, double iconSize) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: TextButton(
        onPressed: () {
          if (value == 'del') {
            _onDeletePressed();
          } else {
            _onNumberPressed(value);
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.1),
          shape: const CircleBorder(),
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width > 600 ? 25.0 : 15.0,
          ),
        ),
        child:
            value == 'del'
                ? Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: iconSize,
                )
                : Text(
                  value,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
