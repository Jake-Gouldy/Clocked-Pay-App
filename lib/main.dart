import 'package:flutter/material.dart';
import 'package:clocked_pay/pages/debug_screen.dart';
import 'package:clocked_pay/pages/home.dart';
import 'package:clocked_pay/pages/earnings.dart';
import 'package:clocked_pay/pages/profile.dart';
import 'package:clocked_pay/pages/settings.dart';
import 'package:clocked_pay/services/dialogues.dart';

/// App entry point.
///
/// This is not final. Right now I’m mainly using this file to:
/// - set up the global theme
/// - register routes for quick navigation during UI work
/// - keep placeholder screens/dialogues reachable while flows are unfinished
void main() {
  // I disable ripple/splash across the app while I’m dialing in the UI.
  // If this hurts the “tap” feel later, I’ll reintroduce subtle pressed states.
  const noOverlay = WidgetStatePropertyAll<Color>(Colors.transparent);
  const noSide = WidgetStatePropertyAll<BorderSide>(BorderSide.none);

  // Shared rounded shape for buttons so everything feels consistent.
  final noShape = WidgetStatePropertyAll<RoundedRectangleBorder>(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      side: BorderSide.none,
    ),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',

        // UI-only choice for now: no splash effects anywhere.
        splashFactory: NoSplash.splashFactory,

        scaffoldBackgroundColor: const Color(0xFF0F1113),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F1113),
          iconTheme: IconThemeData(color: Color(0xFFE9EDF1)),
        ),

        // This text scale is tuned for the current design pass, not “final typography”.
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            height: 1.15,
            color: Color(0xFFE9EDF1),
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            height: 1.2,
            color: Color(0xFFE9EDF1),
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            height: 1.25,
            color: Color(0xFFE9EDF1),
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.5,
            height: 1.35,
            color: Color(0xFFE9EDF1),
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 13.5,
            height: 1.35,
            color: Color(0xFFA9B2BC),
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            height: 1.3,
            color: Color(0xFF7F8A96),
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontSize: 15,
            height: 1.0,
            color: Color(0xFFA9B2BC),
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            height: 1.0,
            color: Color(0xFFA9B2BC),
            fontWeight: FontWeight.w500,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            height: 1.0,
            color: Color(0xFF7F8A96),
            fontWeight: FontWeight.w500,
          ),
        ),

        // Button styling is UI-scaffolding right now; logic/state is coming later.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: noOverlay,
            side: noSide,
            shape: noShape,
            elevation: const WidgetStatePropertyAll(0),
            shadowColor: noOverlay,
            surfaceTintColor: noOverlay,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: noOverlay,
            side: noSide,
            shape: noShape,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            overlayColor: noOverlay,
            side: noSide,
            shape: noShape,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            overlayColor: noOverlay,
            side: noSide,
            shape: noShape,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            overlayColor: noOverlay,
            side: noSide,
            shape: noShape,
          ),
        ),

        cardTheme: CardThemeData(
          color: const Color(0xFF1A1E22),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),

      // Routes are here mainly so I can jump around quickly while building screens.
      // A proper router/setup can come later when flows are locked in.
      routes: {
        "/": (context) => const Settings(),
        "/home": (context) => const Home(),
        "/earnings": (context) => const Earnings(),
        "/profile": (context) => const Profile(),
        "/settings": (context) => const Settings(),

        // Dev-only screen for testing UI bits as I build them.
        "/debug": (context) => const DebugScreen(),

        // Placeholder dialogues used during UI work (not final behavior yet).
        "/customer_dialogue": (context) => const CustomerDialogue(),
        "/location_dialogue": (context) => const LocationDialogue(),
      },
    ),
  );
}