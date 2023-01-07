import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/post_0.1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PageController postController = PageController(
    viewportFraction: 1
  );

  final List<Color> colors = [
    const Color(0xFF7f6dfe),
    const Color(0xFFfec3dc),
    const Color(0xFFb8fe66),
    const Color(0xFFfefefe),
    const Color(0xFFa6cbc4),
  ];

  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [
      SystemUiOverlay.bottom
    ]);
  }

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: postController,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return PostOne(postIndex: index,);
          },
        )
      ),
    );
  }
}