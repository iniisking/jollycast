import 'package:flutter/material.dart';
import 'package:jollycast/view/navigation/bottom_nav_bar.dart';
import 'package:jollycast/view/screens/discover/discover_screen.dart';
import 'package:jollycast/view/screens/categories/categories_screen.dart';
import 'package:jollycast/view/screens/library/library_screen.dart';
import 'package:jollycast/view/widgets/mini_player.dart';
import 'package:jollycast/view/widgets/connectivity_banner.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  List<Widget> get _screens => [
    const DiscoverScreen(),
    const CategoriesScreen(),
    const LibraryScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ConnectivityBanner(),
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _screens),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(),
          BottomNavBar(currentIndex: _currentIndex, onTap: _onNavItemTapped),
        ],
      ),
    );
  }
}
