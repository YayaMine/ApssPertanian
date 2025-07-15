import 'package:appspertanian/Form/Register.dart';
import 'package:appspertanian/Form/screen.dart';
import 'package:appspertanian/Screen/PinScreen.dart';
import 'package:appspertanian/helpers/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Log1 extends StatefulWidget {
  const Log1({super.key});

  @override
  State<Log1> createState() => _Log1State();
}

class _Log1State extends State<Log1> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final dbHelper = DatabaseHelper();
  final LocalAuthentication auth = LocalAuthentication();

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = await dbHelper.getUserByEmail(email);

      if (user != null && user.password == password) {
        await _handleSuccessfulLogin(email);
      } else {
        _showSnackBar('Email atau password salah.', isError: true);
      }
    }
  }

  Future<void> _handleSuccessfulLogin(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_user_email', email);

    final isBiometricEnabled = prefs.getBool('biometric_enabled') ?? false;

    if (!isBiometricEnabled) {
      final bool canAuthenticate = await auth.canCheckBiometrics;
      if (canAuthenticate && mounted) {
        final bool? enableBiometrics = await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Aktifkan Login Cepat'),
                content: const Text(
                  'Apakah Anda ingin menggunakan sidik jari/wajah untuk login lebih cepat di kemudian hari?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Nanti Saja'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Ya, Aktifkan'),
                  ),
                ],
              ),
        );

        if (enableBiometrics == true) {
          await prefs.setBool('biometric_enabled', true);
          _showSnackBar('Login biometrik diaktifkan!');
        }
      }
    }

    _showSnackBar('Login berhasil!');
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PinScreen()),
      );
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Pindai sidik jari atau wajah Anda untuk login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      _showSnackBar('Error: ${e.message}', isError: true);
      return;
    }
    if (!mounted) return;

    if (authenticated) {
      final prefs = await SharedPreferences.getInstance();
      final isBiometricEnabled = prefs.getBool('biometric_enabled') ?? false;
      final lastUserEmail = prefs.getString('last_user_email');

      if (isBiometricEnabled &&
          lastUserEmail != null &&
          lastUserEmail.isNotEmpty) {
        _showSnackBar('Otentikasi biometrik berhasil!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PinScreen()),
        );
      } else {
        _showSnackBar(
          'Fitur belum diaktifkan. Silakan login dengan email & password terlebih dahulu.',
          isError: true,
        );
      }
    } else {
      _showSnackBar('Otentikasi gagal.', isError: true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF14A741),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenHeight * 0.02,
              ),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Screen2(),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Sign In',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: screenWidth * 0.12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Selamat datang kembali, silakan login untuk lanjut.',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                top: screenHeight * 0.10,
                left: screenWidth * 0.08,
                right: screenWidth * 0.08,
                bottom:
                    screenHeight * 0.05 +
                    MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: 'Email',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.025,
                          horizontal: screenWidth * 0.05,
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 65, 65, 65),
                        ),
                        hintText: 'Masukan email',
                        hintStyle: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 65, 65, 65),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF14A741),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                      obscureText: true,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: 'Password',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.025,
                          horizontal: screenWidth * 0.05,
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 65, 65, 65),
                        ),
                        hintText: 'Masukan password',
                        hintStyle: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 92, 92, 92),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF14A741),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF14A741),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, screenHeight * 0.07),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'atau login dengan biometrik',
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.fingerprint,
                              size: screenHeight * 0.05,
                              color: const Color(0xFF14A741),
                            ),
                            onPressed: _authenticateWithBiometrics,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                          ),
                          child: Text(
                            'Or continue with',
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Login dengan Google belum tersedia.',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size.fromHeight(screenHeight * 0.07),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Google.png',
                                  height: screenHeight * 0.03,
                                ),
                                SizedBox(width: screenWidth * 0.025),
                                Text(
                                  'Google',
                                  style: GoogleFonts.roboto(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Login dengan Facebook belum tersedia.',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1877F2),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size.fromHeight(screenHeight * 0.07),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.facebook, size: screenHeight * 0.03),
                                SizedBox(width: screenWidth * 0.025),
                                Text(
                                  'Facebook',
                                  style: GoogleFonts.roboto(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
