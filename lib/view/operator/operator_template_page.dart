import 'package:flutter/material.dart';

class OperatorTemplatePage extends StatelessWidget {
  final Widget child;
  final Widget bottom;
  final String title;
  final Widget? appbar;
  const OperatorTemplatePage(
      {super.key,
      required this.child,
      required this.bottom,
      required this.title,
      this.appbar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottom,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        foregroundColor: Colors.white,
        title: appbar ?? Text(
          title,
          style: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Stack(children: [
        Positioned(
          top: -200,
          right: -200,
          child: Opacity(
            opacity: 0.45,
            child: Container(
              width: 600,
              height: 600,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  radius: 1,
                  tileMode: TileMode.clamp,
                  colors: [
                    Color(0xff4338CA),
                    Color.fromARGB(255, 0, 0, 0),
                    Color(0xff4338CA),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -200,
          left: -200,
          child: Opacity(
            opacity: 0.75,
            child: Container(
              width: 600,
              height: 600,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  radius: 1,
                  tileMode: TileMode.clamp,
                  colors: [
                    Color(0xff4338CA),
                    Color.fromARGB(255, 0, 0, 0),
                    Color(0xff4338CA),
                  ],
                ),
              ),
            ),
          ),
        ),
        child,
      ]),
      // body:
    );
  }
}
