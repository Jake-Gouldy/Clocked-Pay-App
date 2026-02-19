import 'package:flutter/material.dart';

/// Bottom navigation bar.
///
/// This is still UI scaffolding:
/// - routing is basic (named routes)
/// - the center action button doesn’t do anything yet
/// - selection/active state isn’t wired up yet (I’ll add that once navigation is final)
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  // I keep taps “clean” while I’m building the UI (no ripple/splash).
  static const _noOverlay = WidgetStatePropertyAll<Color>(Colors.transparent);

  // Subtle border to lift the bar off the background.
  static const _border = Color(0x0FFFFFFF);

  void _go(BuildContext context, String route) {
    // I use replacement so I don’t stack the same pages repeatedly.
    Navigator.pushReplacementNamed(context, route);
  }

  Widget _navIcon(
      BuildContext context,
      IconData icon,
      double size,
      String route,
      ) {
    return IconButton(
      onPressed: () => _go(context, route),
      icon: Icon(icon, size: size),
      color: Colors.white,
      style: const ButtonStyle(overlayColor: _noOverlay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: SizedBox(
        height: 70,
        child: Material(
          color: Colors.transparent,
          elevation: 8,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1E22),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: _border, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navIcon(context, Icons.home, 22.5, "/home"),
                _navIcon(context, Icons.bar_chart_rounded, 25, "/earnings"),

                const SizedBox(width: 0.5),

                // Placeholder: this will open the “add shift / add entry” flow later.
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  elevation: 0,
                  highlightElevation: 0,
                  child: const Icon(Icons.add, color: Colors.white),
                ),

                const SizedBox(width: 0.5),

                _navIcon(context, Icons.person, 25, "/profile"),
                _navIcon(context, Icons.settings, 22.5, "/settings"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}