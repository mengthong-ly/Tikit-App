import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  late TabController tabController;
  final double expandedHeight = 300.0; // Adjusted for better demonstration
  late AutoScrollController scrollController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    scrollController = AutoScrollController();
    super.initState();
  }

  // for animatioin
  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            centerTitle: false,
            title: buildTitle(),
            expandedHeight: 500,
            collapsedHeight: kToolbarHeight,
            flexibleSpace: buildSpacebar(),
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     List.generate(
          //       20,
          //       (index) => Container(
          //         height: 100,
          //         margin: const EdgeInsets.symmetric(vertical: 8.0),
          //         color: index.isEven ? Colors.grey[300] : Colors.grey[200],
          //         child: Center(child: Text("Item $index")),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildSpacebar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.biggest.height;
        final collapsePoint =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          onCollapsed(top <= collapsePoint);
        });

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Expanded Title",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 16.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("CTA Button"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTitle() {
    return AnimatedOpacity(
      opacity: isCollapsed ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      child: const Text(
        "Collapsed Title",
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
