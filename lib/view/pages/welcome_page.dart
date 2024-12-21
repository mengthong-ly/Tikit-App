import 'package:event_with_thong/theme/theme.dart';
import 'package:event_with_thong/view/components/welcome_page_title.dart';
import 'package:event_with_thong/view/components/welcome_page_image_container.dart';
import 'package:event_with_thong/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController controller = PageController();
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      FirstWelcomePage(
        controller: controller,
      ),
      SecondWelcomePage(
        controller: controller,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[index]),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    effect: WormEffect(
                        dotWidth: 13,
                        dotHeight: 13,
                        activeDotColor: TAppTheme.lightTheme.primaryColor),
                    controller: controller,
                    count: pages.length,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: const Text("Skip >"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class SecondWelcomePage extends StatelessWidget {
  const SecondWelcomePage({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30,
              ),
              const WelcomePageTitle(
                  title: 'Easier Faster Safer ',
                  subTitle:
                      'Every Event is now your with just a\nsingle click'),
              const WelcomePageImageContainer(
                img: 'assets/welcomeScreen/hg3.png',
              ),
              const SizedBox(
                height: 50,
              ),
              TElevatedButton(
                  label: 'Next',
                  onPress: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TElevatedButton extends StatelessWidget {
  final String label;
  final void Function() onPress;
  final bool isRed;
  const TElevatedButton(
      {super.key,
      required this.label,
      required this.onPress,
      this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: onPress,
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xffFD2942)),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class TElevatedButtonSmall extends StatelessWidget {
  final String label;
  final void Function() onPress;
  final bool isRed;
  const TElevatedButtonSmall(
      {super.key,
      required this.label,
      required this.onPress,
      this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 40,
      child: ElevatedButton(
        onPressed: onPress,
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xffFD2942)),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );
  }
}

class FirstWelcomePage extends StatelessWidget {
  final PageController controller;
  const FirstWelcomePage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30,
              ),
              const WelcomePageTitle(
                title: 'Let\'s start the Event!',
                subTitle: 'Go and Get your Tickets Now...\n',
              ),
              const WelcomePageImageContainer(
                img: 'assets/welcomeScreen/hg19.png',
              ),
              const SizedBox(
                height: 50,
              ),
              TElevatedButton(
                label: 'Next',
                onPress: () {
                  controller.nextPage(
                      duration: Durations.long2, curve: Easing.legacy);
                },
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
