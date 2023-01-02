import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({
    Key? key,
    required this.myChild
  }) : super(key: key);

  final Widget myChild;

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> with TickerProviderStateMixin {

  PageController pageController = PageController(initialPage: 0);

  // Animation Stuff -- S t a r t --
  late AnimationController controller;
  late Animation<Offset> animation;
  late Animation<double> sAnimation;
  late Animation<double> borderRadiusAnimation;
  late Animation<double> testAnimation;
  // Animation Stuff -- E n d --

  bool ignoringPointer = false;

  @override
  void initState(){ super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), reverseDuration: const Duration(milliseconds: 300));
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.5, 0)).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutSine));
    sAnimation = Tween<double>(begin: 1, end: 0.9).animate(controller);
    borderRadiusAnimation = Tween<double>(begin: 5, end: 20).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    log(ignoringPointer.toString());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          width: width,
          color: const Color(0xFF1c3356),
          child: Column( crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton( onPressed: (){
                  setState(() {
                    context.push('/lobby');
                    ignoringPointer = false;
                  });
                  controller.reverse();
                },
                child: const Text("h o m e", style: TextStyle(color: Colors.white),),
              ),
              TextButton( onPressed: (){
                  setState(() {
                    context.push('/settings');
                    ignoringPointer = false;
                  });
                  controller.reverse();
                },
                child: const Text("s e t t i n g s", style: TextStyle(color: Colors.white),),
              ),
              TextButton( onPressed: (){
                  setState(() {
                    context.push('/details');
                    ignoringPointer = false;
                  });
                  controller.reverse();
                },
                child: const Text("d e t a i l s", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
        ScaleTransition( scale: sAnimation,
          child: SlideTransition( position: animation,
            child: Container( height: height, width: width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow( color: Colors.black, blurRadius: 30, spreadRadius: -20 )
                ]
              ),
              child: AnimatedBuilder( animation: controller, builder: (context, child) => ClipRRect(borderRadius: BorderRadius.circular(borderRadiusAnimation.value),
                  child: GestureDetector(
                    onTap: () {
                      controller.reverse();
                      setState(() => ignoringPointer = false);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.black.withOpacity(1),
                      body: Stack(
                        children: [
                          IgnorePointer(
                            ignoring: ignoringPointer,
                            child: widget.myChild
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.forward();
                                  setState(() => ignoringPointer = true);
                                },
                                icon: const Icon(Icons.ads_click, color: Colors.white)
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}