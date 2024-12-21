import 'package:event_with_thong/view/components/event_home_page.dart';
import 'package:event_with_thong/view/pages/booking_page.dart';
import 'package:event_with_thong/view/pages/cart_page.dart';
import 'package:event_with_thong/view/pages/settings_home_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  late final List<Widget> pages;
  int currentIndex = 0;
  final double _offset = 15;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    pages = [
      const EventHomePage(),
      const BookingHome(),
      const CartPage(),
      const SettingsHomePage(),
    ];
    
    // so it will start from 0

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: _offset, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Easing.legacy),
    );
    _onNavItemSelected(0);
  }

  void _onNavItemSelected(int index) async {
    setState(() {
      currentIndex = index;
    });
    _animationController.reset();
    await _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        selectedIndex: currentIndex,
        elevation: 0,
        onDestinationSelected: (value) => _onNavItemSelected(value),
        indicatorColor: Theme.of(context).primaryColor,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded, color: Color(0xfff4f4f4)),
            icon: Icon(Icons.home),
            label: '',
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.shopping_bag, color: Color(0xfff4f4f4)),
              icon: Icon(Icons.shopping_bag),
              label: ''),
          NavigationDestination(
            selectedIcon:
                Icon(Icons.shopping_cart_rounded, color: Color(0xfff4f4f4)),
            icon: Icon(Icons.shopping_cart_rounded),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings, color: Color(0xfff4f4f4)),
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animationController.value,
            child: Transform.translate(
              offset: Offset(0, _animation.value),
              child: pages[currentIndex],
            ),
          );
        },
      ),
    );
  }
}
