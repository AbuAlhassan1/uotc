import 'package:flutter/material.dart';

class PostOne extends StatelessWidget {
  const PostOne({super.key});

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Container(
      width: width, height: 50,
      color: Colors.red,
      margin: const EdgeInsets.all(10),
    );
  }
}