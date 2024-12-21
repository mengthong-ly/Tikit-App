import 'package:event_with_thong/view/pages/home_page.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/theme/theme.dart';
import 'package:event_with_thong/view/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventSliverAppBar extends StatelessWidget {
  final bool isCollapsed;
  final ValueChanged<bool> onCollapsed;
  final String welcomeText;
  final bool isOperator;

  const EventSliverAppBar({
    super.key,
    required this.isCollapsed,
    required this.onCollapsed,
    required this.welcomeText,
    required this.isOperator,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 160,
      centerTitle: false,
      collapsedHeight: kToolbarHeight,
      toolbarHeight: kToolbarHeight,
      surfaceTintColor: Colors.transparent,
      // leading: const SizedBox.shrink(),
      actions: isOperator
          ? [
              IconButton(
                icon: const Icon(Icons.exit_to_app, color: Colors.white,),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                    
                  );
                },
              ),
            ]
          : null,
      backgroundColor: isOperator
          ? Colors.transparent
          : context.read<ThemeProvider>().theme == TAppTheme.lightTheme
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
      pinned: true,
      title: !isOperator
          ? AnimatedOpacity(
              opacity: isCollapsed ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: const CustomAppbar(),
            )
          : null,
      shadowColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          final collapsePoint =
              MediaQuery.of(context).viewPadding.top + kToolbarHeight;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Avoid updating state unnecessarily
            if (isCollapsed != (top <= collapsePoint)) {
              onCollapsed(top <= collapsePoint);
            }
          });

          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: AnimatedContainer(
              duration: const Duration(milliseconds: 500), // Smooth animation
              curve: Curves.easeInOut, // Smooth curve for changes
              color: isOperator
                  ? Colors.transparent
                  : Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      welcomeText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: !isOperator
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
