import 'package:flutter/material.dart';

class CartSliverAppBar extends StatelessWidget {
  const CartSliverAppBar(
      {super.key,
      required this.isCollapsed,
      required this.onCollapsed,
      required this.tabController});
  final TabController tabController;
  final bool isCollapsed;
  final ValueChanged<bool> onCollapsed;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SliverAppBar(
        expandedHeight: 160,
        elevation: 0,
        collapsedHeight: kToolbarHeight,
        toolbarHeight: kToolbarHeight,
        title: AnimatedOpacity(
          opacity: isCollapsed ? 1 : 0,
          duration: const Duration(milliseconds: 200),
        ),
        backgroundColor: const Color(0xfff4f4f4),
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            final top = constraints.biggest.height;
            final collapsePoint =
                MediaQuery.of(context).viewPadding.top + kToolbarHeight;

            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                if (isCollapsed != (top <= collapsePoint)) {
                  onCollapsed(top <= collapsePoint);
                }
              },
            );

            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: const BoxDecoration(
                  color: Color(0xfff4f4f4),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Your Cart',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
