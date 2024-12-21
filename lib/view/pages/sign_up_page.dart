import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/home_page.dart';
import 'package:event_with_thong/view/pages/login_page.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String confirmPassword;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    confirmPassword = '';
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || confirmPassword == '' || confirmPassword != password) {
      return 'invalid password';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || email == '') {
      return 'invalid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || password == '') {
      return 'invalid password';
    }
    return null;
  }

  void redirectToHomePage() {
    showSnackbar(context,
        'Welcome ${context.read<AuthenticationProvider>().currentUser?.name ?? 'User'}');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void onSubmit() async {
      _formkey.currentState!.save();
    if (_formkey.currentState!.validate()) {
      if (await context
          .read<AuthenticationProvider>()
          .createUserWithEmailAndPassword(
              email, password, confirmPassword, context)) {

        redirectToHomePage();
      }
    }
  }

  void onSwitchToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 113),
                  Text(
                    'Sign Up',
                    style: TTextTheme.lightTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 73,
                  ),
                  buildEmailTextField(),
                  const SizedBox(height: 17),
                  buildPassTextField(),
                  const SizedBox(height: 17),
                  buildConfirmPassTextField(),
                  const SizedBox(height: 17),
                  buildSignUpButton(context),
                  const SizedBox(height: 62),
                  buildSwtichToLoginPage(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSwtichToLoginPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account'),
        TextButton(
            onPressed: onSwitchToLogin,
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
                elevation: 0,
                splashFactory: NoSplash.splashFactory),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ))
      ],
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return TElevatedButton(label: 'Sign Up', onPress: onSubmit);
  }

  Widget buildEmailTextField() {
    return TTextFormField(
      onSaved: (newValue) {
        email = newValue!;
      },
      validator: (value) => validateEmail(value),
      label: 'Email',
      hint: 'mengthong@gmail.com',
    );
  }

  Widget buildPassTextField() {
    return TTextFormField(
      onSaved: (newValue) {
        password = newValue!;
      },
      validator: (value) => validatePassword(value),
      label: 'Password',
      hint: '********',
    );
  }

  Widget buildConfirmPassTextField() {
    return TTextFormField(
      onSaved: (newValue) {
        confirmPassword = newValue!;
      },
      validator: validateConfirmPassword,
      label: 'Confirm Password',
      hint: '********',
    );
  }
}
