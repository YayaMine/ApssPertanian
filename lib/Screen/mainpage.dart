import 'package:appspertanian/Screen/HomeP.dart';
import 'package:appspertanian/Screen/chart.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<IconData> bottomIcons = [
    Icons.home_filled,
    Icons.add_shopping_cart,
    Icons.favorite_border,
    Icons.person_rounded,
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (currentPage) {
        case 0:
          return const Homep();
        case 1:
          return const Chart();
        case 2:
          return Center(
            child: Text(
              'Profile Page',
              style: TextStyle(fontSize: 32, color: Color(0xFF14A741)),
            ),
          );
        default:
          return Center(
            child: Text(
              'Whats Wrong',
              style: TextStyle(fontSize: 32, color: Color(0xFF14A741)),
            ),
          );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
      bottomNavigationBar: SizedBox(
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            bottomIcons.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = index;
                });
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: currentPage == index ? 24 : 0,
                    width: currentPage == index ? 24 : 0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(.1),
                          spreadRadius: currentPage == index ? 10 : 0,
                          blurRadius: currentPage == index ? 10 : 0,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    bottomIcons[index],
                    size: 30,
                    color:
                        currentPage == index
                            ? Color(0xFF14A741)
                            : Color(0xFF14A741).withOpacity(.3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
