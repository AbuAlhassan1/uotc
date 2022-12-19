import 'package:flutter/material.dart';

class UotcBottomNavigationBar extends StatelessWidget {
  const UotcBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Positioned(
      bottom: 0,
      child: Container(
        width: width, height: 60,
        color: Colors.white,
      ),
    );
  }
}