import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/login_page.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool isOPTRecived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 113,
              ),
              Text(
                'Reset Password',
                style: TTextTheme.lightTextTheme.headlineLarge,
              ),
              const SizedBox(height: 73),
              TTextFormField(
                label: 'Phone Number',
                hint: 'mengthong@gmail.com',
                suffixIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      isOPTRecived = true;
                    });
                  },
                  style: TextButton.styleFrom(
                      elevation: 0, splashFactory: NoSplash.splashFactory),
                  child: Text(
                    'Send OTP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              if (isOPTRecived) ...[
                const TTextFormField(
                  label: 'OPT',
                  hint: '0000',
                ),
                const SizedBox(height: 17),
                const TTextFormField(
                  label: 'New Password',
                  hint: '********',
                ),
                const SizedBox(height: 17),
                const TTextFormField(
                  label: 'Confirm new Password',
                  hint: '********',
                ),
                const SizedBox(height: 17),
                TElevatedButton(
                    label: 'Reset',
                    onPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  LoginPage(),
                        ),
                      );
                    })
              ]
            ],
          ),
        ),
      ),
    );
  }
}
