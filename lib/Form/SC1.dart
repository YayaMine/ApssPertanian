import 'package:flutter/material.dart';

class Sc1 extends StatefulWidget {
  const Sc1({super.key});

  @override
  State<Sc1> createState() => _Sc1State();
}

class _Sc1State extends State<Sc1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -180,
            right: -140,
            child: Container(
              height: 400,
              width: 280,
              decoration: BoxDecoration(
                color: Color(0xFF14A741),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -220,
            left: -250,
            child: Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                color: Color(0xFF14A741),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
