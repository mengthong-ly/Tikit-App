import 'package:event_with_thong/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Widget? trailing;
  final VoidCallback? callback;
  const SettingItem({
    super.key,
    required this.iconData,
    required this.label,
    this.callback,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        children: [
          const SizedBox(height: 45),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              // color: context.watch<ThemeProvider>().theme == TAppTheme.darkTheme ? Color(0xfff4f4f4) : context.watch<ThemeProvider>().theme.scaffoldBackgroundColor,
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              size: 17,
              color: const Color(0xFF4F4F4F),
            ),
          ),
          const SizedBox(width: 18),
          Text(
            // items[key.key][0],
            label,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          trailing ?? const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget buildProfileCard(BuildContext context, UserModel user) {
    return Align(
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                color: Color.fromARGB(19, 69, 69, 69))
          ],
        ),
        child: ClipRRect(
          child: Stack(
            children: [
              Positioned(
                left: 30,
                bottom: 60,
                child: Align(
                  child: Transform.scale(
                    scale: 3,
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              strokeAlign: 0.05,
                              color: const Color(0xffFD2942))),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -40,
                bottom: -60,
                child: Align(
                  child: Transform.scale(
                    scale: 3,
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              strokeAlign: 0.05,
                              color: const Color(0xffFD2942))),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xffFD2942))),
                      width: 90,
                      height: 90,
                      child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/8.png')),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xffFD2942),
                            borderRadius: BorderRadius.circular(3)),
                        width: 130,
                        height: 25,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              user.name ?? 'User',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Text(user.email)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
