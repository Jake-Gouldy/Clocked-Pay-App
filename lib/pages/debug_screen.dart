import 'package:flutter/material.dart';
import 'package:clocked_pay/widgets/bottom_nav_bar.dart';
import 'package:clocked_pay/widgets/full_width_card.dart';
import 'package:signature/signature.dart';
import 'package:dotted_border/dotted_border.dart';


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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FullWidthCard(
              child: Row(
                children: [
                  Icon(Icons.alarm, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    "Today",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            FullWidthCard(
              child: Column(
                children: [
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: const Radius.circular(12),
                      color: Colors.white.withOpacity(0.08),
                      dashPattern: [8, 4],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 120,
                        color: const Color(0xFF20252B),
                        child: Signature(
                          controller: _controller,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2,),
                  Center(
                    child:TextButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      child: const Text("Clear"),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                _controller.clear();
              },
              child: const Text("Clear"),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
