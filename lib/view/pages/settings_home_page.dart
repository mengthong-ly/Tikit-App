import 'dart:ui';

import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/operator/operator_page.dart';
import 'package:event_with_thong/view/pages/personal_profile_page.dart';
import 'package:event_with_thong/view/pages/setting_page_title.dart';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/theme/theme.dart';
import 'package:event_with_thong/view/pages/Edit_form.dart';
import 'package:event_with_thong/view/pages/login_page.dart';
import 'package:event_with_thong/view/pages/setting_item.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsHomePage extends StatefulWidget {
  const SettingsHomePage({super.key});

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage> {
  late UserModel currentUser;
  final bool isLogin = true;

  Future<void> load() async {
    await context.read<AuthenticationProvider>().loadCurrentUser();
    currentUser =
        context.read<AuthenticationProvider>().currentUser as UserModel;
  }

  void onEdit(UserModel user) async {
    final UserModel? model = await Navigator.push<UserModel>(
      context,
      MaterialPageRoute(
        builder: (context) => EditForm(
          user: user,
        ),
      ),
    );
    if (model != null) {
      await context.read<AuthenticationProvider>().updateUser(model); // work
      currentUser = context.read<AuthenticationProvider>().currentUser!;
      setState(() {});
    }
  }

  void onLogout(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    await context.read<AuthenticationProvider>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<AuthenticationProvider>(
                            builder: (context, authProvider, child) {
                              // final user = authProvider.currentUser!;
                              return buildProfileCard(context, currentUser);
                            },
                          ),
                          // buildProfileCard(context, user),
                          const SizedBox(
                            height: 20,
                          ),
                          buildAdminButton(context),
                          buildbody(context, genralSettings, otherSettings)
                          // TElevatedButton(label: 'Edit', onPress: () {})
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            );
          }
        });
  }

  Widget buildAdminButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OperatorPage()),
          (route) => false, 
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(43, 0, 0, 0),
                blurRadius: 10,
                spreadRadius: 1),
          ],
          gradient: const RadialGradient(
            radius: 2,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color(0xffFD2942),
              Color.fromARGB(255, 0, 0, 0),
              Color(0xffFD2942),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Admin Mode',
            style: TextStyle(
              fontSize: TTextTheme.lightTextTheme.headlineMedium!.fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildbody(BuildContext context, List<SettingItem> genralSettings,
      List<SettingItem> otherSettings) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingPageTitle(
          title: 'General',
        ),
        buildSettingContent(context, genralSettings),
        const SettingPageTitle(title: 'Other'),
        buildSettingContent(context, otherSettings),
        const SizedBox(
          height: 30,
        ),
        isLogin
            ? TElevatedButton(
                label: 'Logout',
                onPress: () => onLogout(context),
                isRed: true,
              )
            : TElevatedButton(
                label: 'Login',
                onPress: () {},
              )
      ],
    );
  }

  Widget buildProfileCard(BuildContext context, UserModel user) {
    double width = MediaQuery.of(context).size.width - 40;
    return Align(
      child: GestureDetector(
        // onTap: () => onEdit(user),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalProfilePage(
                      user: user,
                      callback: onEdit,
                    )),
          );
        },
        child: Container(
          width: width,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 5,
                  color: Color.fromARGB(19, 69, 69, 69))
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Transform.scale(
                    alignment: AlignmentDirectional.center,
                    scale: 1.3,
                    child: Image.asset(
                      'assets/9852434.png',
                    ),
                  ),
                ),
                const Positioned(
                  top: 10,
                  right: 15,
                  child: Text(
                    'Edit >',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      // color: Colors.white,
                      width: width / 2.6,
                      child: Image.asset('assets/8.png'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 100,
                          height: 20,
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: const Color(0xffFD2942)),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              user.name ?? 'anonymous',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor:
      //     context.watch<ThemeProvider>().theme.scaffoldBackgroundColor,
      systemOverlayStyle:
          context.watch<ThemeProvider>().theme == TAppTheme.lightTheme
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      title: buildTitleAppbar(context),
    );
  }

  Widget buildSettingContent(
    BuildContext context,
    List<SettingItem> items,
  ) {
    return Column(
      children: [
        const SizedBox(height: 15),
        ...items.map(
          (item) {
            return item;
          },
        )
      ],
    );
  }

  Widget buildTitleAppbar(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'Settings',
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}
