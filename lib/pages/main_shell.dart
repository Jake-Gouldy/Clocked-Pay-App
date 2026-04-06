import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home.dart';
import 'earnings.dart';
import 'profile.dart';
import 'settings.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  late final PageController _pageController;

  final List<Widget> _pages = const [
    Home(),
    Earnings(),
    Profile(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    if (index == 2) {
      // middle FAB item
      return;
    }

    int pageIndex;
    if (index < 2) {
      pageIndex = index;
    } else {
      pageIndex = index - 1;
    }

    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int pageIndex) {
    int navIndex;
    if (pageIndex < 2) {
      navIndex = pageIndex;
    } else {
      navIndex = pageIndex + 1;
    }

    setState(() {
      _currentIndex = navIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onNavTapped,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF13171C),
        items: [
          const Icon(Icons.home, size: 30, color: Colors.white),
          const Icon(Icons.bar_chart, size: 30, color: Colors.white),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const Icon(Icons.person, size: 30, color: Colors.white),
          const Icon(Icons.settings, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}