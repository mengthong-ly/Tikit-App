import 'package:event_with_thong/theme/theme.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 30,
                child:
                    context.watch<ThemeProvider>().theme == TAppTheme.darkTheme
                        ? Image.asset('assets/dark-mode-logo.png') : Image.asset('assets/light-mode-logo.png'),
              ),
              const Spacer(),
              const ClipRRect(
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: CircleAvatar(
                    backgroundColor: Color(0xfff4f4f4),
                    backgroundImage: AssetImage('assets/8.png'),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
