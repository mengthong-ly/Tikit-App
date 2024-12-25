import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/home_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        child: TElevatedButton(
          label: 'Back To Home',
          onPress: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 255, 255, 255),
          // gradient: LinearGradient(colors: [Color(value)]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Lottie.asset('assets/success-light.json',
                    width: 300, repeat: false),
              ),
              Center(
                child: SizedBox(
                  width: 370,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 250,
                      ),
                      const Text(
                        'Success!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your e-ticket has been sent to your booking. Please present it at the event entrance.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: context.read<ThemeProvider>().isDarkMode
                                ? Colors.white
                                : const Color(0xff101010)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        child: Container(
                          width: 320,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: context.read<ThemeProvider>().isDarkMode ? Colors.white : Color(0xff101010),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Please check your booking',
                              style: TextStyle(
                                  fontSize: TTextTheme
                                      .lightTextTheme.titleLarge!.fontSize,
                                  fontWeight: TTextTheme
                                      .lightTextTheme.titleLarge!.fontWeight,
                                  color:
                                      context.read<ThemeProvider>().isDarkMode
                                          ? Colors.white
                                          : const Color(0xff101010)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
