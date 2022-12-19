import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'bottom_navigation_bar.dart';

class Lobby extends StatelessWidget {
  const Lobby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UotcColors.offBlack,
      body: Stack(
        children: [
          UotcBottomNavigationBar(),
        ],
      ),
    );
  }
}