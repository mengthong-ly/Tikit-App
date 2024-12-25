import 'dart:async';
import 'dart:ui';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/view/pages/home_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TikitApp extends StatefulWidget {
  const TikitApp({super.key});

  @override
  State<TikitApp> createState() => _TikitAppState();
}

class _TikitAppState extends State<TikitApp> with TickerProviderStateMixin {
  bool isFlash = true;
  bool isLogin = false;

  late final AnimationController _controller;
  late final Animation<Alignment> _alignmentAnimation1;
  late final Animation<Alignment> _alignmentAnimation2;
  late final Animation<Alignment> _alignmentAnimation3;

  late Timer _animationTimer;

  @override
  void initState() {
    super.initState();
    // Logger().d(context.read<AuthenticationProvider>().currentUser);
    // Set flash timeout
    Timer(const Duration(seconds: 5), setFlashOff);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7), // Adjust as needed
    )..repeat(reverse: true); // Continuously animate

    // Define tweens for alignment animations
    _alignmentAnimation1 = Tween<Alignment>(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _alignmentAnimation2 = Tween<Alignment>(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _alignmentAnimation3 = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.topLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller;

    // Start flash timeout
    Timer(const Duration(seconds: 5), setFlashOff);
  }

  void triggerLogin() {
    setState(() {
      isLogin = context.read<AuthenticationProvider>().currentUser != null;
    });
  }

  void setFlashOff() {
    setState(() {
      isFlash = false;
    });
  }

  @override
  void dispose() {
    _animationTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> loader() async {
    await context.read<AuthenticationProvider>().initialLoader();
    // await context.read<ProductModelProvider>().load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loader(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && !isFlash) {
          isLogin = context.watch<AuthenticationProvider>().currentUser != null;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'EventWithThong',
              theme: context.watch<ThemeProvider>().theme,
              home: isLogin ? const HomePage() : const WelcomePage());
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'EventWithThong',
            theme: context.watch<ThemeProvider>().theme,
            home: Scaffold(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              body: buildAnimationBackground(context),
            ),
          );
        }
      },
    );
  }

  Widget buildAnimationBackground(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Stack(
        children: [
          // First animated container
          AnimatedAlign(
              curve: Curves.easeInOut,
              alignment: _alignmentAnimation1.value,
              duration: const Duration(seconds: 0),
              child: buildBackgroundAnimationBall(context)),
          AnimatedAlign(
              curve: Curves.easeInOut,
              alignment: _alignmentAnimation2.value,
              duration: const Duration(seconds: 0),
              child: buildBackgroundAnimationBall(context)),

          // Second animated container
          AnimatedAlign(
            curve: Curves.easeInOut,
            alignment: _alignmentAnimation3.value,
            duration: const Duration(seconds: 0),
            child: buildBackgroundAnimationBall(context),
          ),

          // Background blur
          buildBlurLayer(),
          buildLogo()
        ],
      ),
    );
  }

  Widget buildLogo() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Image.asset('assets/dark-mode-logo.png'),
        ),
      ),
    );
  }

  Widget buildBlurLayer() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
      child: const SizedBox.shrink(),
    );
  }

  Widget buildBackgroundAnimationBall(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        gradient: LinearGradient(
          colors: [
            Color(0xffFD2942),
            Color(0xff4338CA),
          ],
        ),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 550, sigmaY: 550),
          child: const SizedBox.shrink()),
    );
  }
}
