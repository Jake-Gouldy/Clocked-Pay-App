import 'package:flutter/material.dart';

class CustomerDialogue extends StatefulWidget {
  const CustomerDialogue({super.key});

  @override
  State<CustomerDialogue> createState() => _CustomerDialogueState();
}

class _CustomerDialogueState extends State<CustomerDialogue> {
  @override
  Widget build(BuildContext context) {
    return ScreenDialogueTemplate(isCustomerScreen: true);
  }
}

class LocationDialogue extends StatefulWidget {
  const LocationDialogue({super.key});

  @override
  State<LocationDialogue> createState() => _LocationDialogueState();
}

class _LocationDialogueState extends State<LocationDialogue> {
  @override
  Widget build(BuildContext context) {
    return ScreenDialogueTemplate(isCustomerScreen: false);
  }
}

class ScreenDialogueTemplate extends StatefulWidget {

  final bool isCustomerScreen;

  const ScreenDialogueTemplate({
    super.key,
    required this.isCustomerScreen
  });

  @override
  State<ScreenDialogueTemplate> createState() => _ScreenDialogueTemplateState();
}

class _ScreenDialogueTemplateState extends State<ScreenDialogueTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Manage ${widget.isCustomerScreen ? "Customers" : "Locations"}",
            style: Theme.of(context).textTheme.headlineMedium
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: EmptyScreenDialogue(isCustomerScreen: widget.isCustomerScreen),
    );
  }
}

class EmptyScreenDialogue extends StatefulWidget {

  final bool isCustomerScreen;
  const EmptyScreenDialogue({
    super.key,
    required this.isCustomerScreen
  });

  @override
  State<EmptyScreenDialogue> createState() => _EmptyScreenDialogueState();
}

class _EmptyScreenDialogueState extends State<EmptyScreenDialogue> {
  late final ImageProvider _img;

  @override
  void initState() {
    super.initState();
    _img = AssetImage(
      widget.isCustomerScreen
          ? "assets/icons/people.png"
          : "assets/icons/maps.png",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(_img, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;

        // Responsive sizes (clamped so it doesn't get silly)
        final imgSize = (w * 0.45).clamp(140.0, 220.0);
        final gapLarge = (h * 0.04).clamp(18.0, 36.0);
        final gapSmall = (h * 0.015).clamp(8.0, 14.0);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Transform.translate(
                offset: const Offset(0, -90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: _img,
                      width: imgSize,
                      height: imgSize,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: gapLarge),
                
                    Text(
                      "No ${widget.isCustomerScreen ? "Customers" : "Locations"} added yet",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: gapSmall),
                
                    Text(
                      "Tap the button below to add your first ${widget.isCustomerScreen ? "Customer" : "Location"}.",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: gapLarge),
                
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 44),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(width: 10),
                          Text(
                            "Add ${widget.isCustomerScreen ? "Customer" : "Location"}",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


