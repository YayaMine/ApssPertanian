import 'package:appspertanian/Form/Log1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Log1State();
}

class _Log1State extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14A741),
      body: Stack(
        children: [
          Positioned(
            bottom: -100,
            child: Container(
              height: 750,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 110, left: 30, right: 30),
                // padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          labelText: 'Email',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
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
                            borderSide: BorderSide(
                              color: Color(0xFF14A741),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          labelText: 'Username',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                          labelStyle: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 65, 65, 65),
                          ),
                          hintText: 'Masukan Username',
                          hintStyle: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 92, 92, 92),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF14A741),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          labelText: 'No Telpon',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                          labelStyle: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 65, 65, 65),
                          ),
                          hintText: 'Masukan No telpon',
                          hintStyle: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 92, 92, 92),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF14A741),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          labelText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
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
                            borderSide: BorderSide(
                              color: Color(0xFF14A741),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Log1()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF14A741),
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              'Or continue Register with',
                              style: GoogleFonts.roboto(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      SizedBox(height: 20),
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
                                minimumSize: Size.fromHeight(55),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Google.png',
                                    height: 22,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Google',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
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
                                backgroundColor: Color(0xFF1877F2),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: Size.fromHeight(55),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.facebook, size: 24),
                                  SizedBox(width: 10),
                                  Text(
                                    'Facebook',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
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
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Log1()),
                );
              },
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Log1()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lorem Ipsum Is simply Apps Kakao Lorem Ipsum Is simply Apps Kakao Negara',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
