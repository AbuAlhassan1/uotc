import 'package:flutter/material.dart';
import 'package:uotc/views/common/post_0.1.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return const PostOne();
        },
      ),
    );
  }
}