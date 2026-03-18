import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:clocked_pay/widgets/full_width_card.dart';
import 'package:signature/signature.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home.dart';
import 'earnings.dart';
import 'profile.dart';
import 'settings.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.white,
    exportBackgroundColor: Colors.transparent,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: PageView(children: [Home(), Earnings(), Profile(), Settings()]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color(0xFF13171C),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.bar_chart, size: 30, color: Colors.white,),
          FloatingActionButton(onPressed: (){}, backgroundColor: Colors.blue, shape: CircleBorder(),child: Icon(Icons.add, color: Colors.white,)),
          Icon(Icons.person, size: 30, color: Colors.white,),
          Icon(Icons.settings, size: 30, color: Colors.white,),

        ],
      )
    );
  }
}
