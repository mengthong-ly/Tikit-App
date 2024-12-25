import 'package:event_with_thong/view/operator/tikit_custom_snack_bar.dart';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/home_page.dart';
import 'package:event_with_thong/view/pages/sign_up_page.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAuthenticated = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onEmailSave(String value) {
    email = value;
  }

  void onpasswordSave(String value) {
    password = value;
  }

  void redirectToHomePage() {
    TikitCustomSnackBar.show(context,
        'Welcome ${context.read<AuthenticationProvider>().currentUser?.name ?? 'User'}');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future<void> onSubmit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if (await context
          .read<AuthenticationProvider>()
          .loginWithEmailAndPassword(email, password, context)) {
        redirectToHomePage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formkey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 113),
                  Text(
                    'Login',
                    style: TTextTheme.lightTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 73),
                  TTextFormField(
                      onSaved: (value) => onEmailSave(value!),
                      validator: (value) => emailValidator(value),
                      label: 'Email',
                      hint: 'mengthong@gmail.com'),
                  const SizedBox(
                    height: 17,
                  ),
                  TTextFormField(
                    onSaved: (value) => onpasswordSave(value!),
                    validator: (value) => passwordValidator(value),
                    label: 'Password',
                    hint: '********',
                  ),
                  const SizedBox(height: 17),
                  TElevatedButton(
                    label: 'Login',
                    onPress: onSubmit,
                  ),
                  const SizedBox(height: 62),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              elevation: 0,
                              splashFactory: NoSplash.splashFactory),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty && !value.contains('@gmail.com')) {
      return 'Invalid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Invalide password';
    }
    return null;
  }
}
