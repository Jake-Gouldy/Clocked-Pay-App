import 'package:clocked_pay/widgets/full_width_card.dart';
import 'package:flutter/material.dart';

/// Settings screen.
///
/// This isn’t final. Right now I’m using it as UI scaffolding:
/// - counts are placeholder values
/// - onTap handlers just route to temporary dialogue screens
/// - real persistence/state will be wired in once the flows are settled
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Simple scroll layout so this can grow without fighting overflow.
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // I keep the header layout consistent with the rest of the app.
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      "Settings",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Placeholder: this will become a proper pay-rate/settings flow.
                const _DoubleCard(
                  topText: "Hourly/Daily",
                  bottomText: "Preset daily rate",
                ),

                const SizedBox(height: 15),

                // Customers/Locations are UI-first right now; dialogues are temporary.
                _DoubleCard(
                  topText: "Customers",
                  topCount: 2,
                  topIcon: Icons.people_alt_outlined,
                  topOnTap: () => Navigator.pushNamed(context, "/customer_dialogue"),
                  bottomText: "Locations",
                  bottomCount: 3,
                  bottomIcon: Icons.location_on_outlined,
                  bottomOnTap: () => Navigator.pushNamed(context, "/location_dialogue"),
                ),

                const SizedBox(height: 15),

                // Placeholder: reminders will eventually be configurable and persisted.
                const FullWidthCard(
                  child: _CardRow(
                    text: "Reminders",
                    icon: Icons.notifications_active_outlined,
                    reminderText: "Sunday",
                  ),
                ),

                // UI note for now; later I’ll swap this for real storage/settings info.
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12.0),
                  child: Text(
                    "All data is stored locally",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Small icon container used on the left side of rows.
/// I keep it as a separate widget so spacing/styling stays consistent.
class _IconBox extends StatelessWidget {
  final IconData icon;

  const _IconBox(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0x0FFFFFFF),
          width: 1,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

/// Card wrapper that renders two stacked settings rows.
/// This is just a layout helper so I don’t repeat the divider/spacing everywhere.
class _DoubleCard extends StatelessWidget {
  final String topText;
  final IconData? topIcon;
  final int? topCount;
  final VoidCallback? topOnTap;

  final String bottomText;
  final IconData? bottomIcon;
  final int? bottomCount;
  final VoidCallback? bottomOnTap;

  const _DoubleCard({
    required this.topText,
    this.topIcon,
    this.topCount,
    this.topOnTap,
    required this.bottomText,
    this.bottomIcon,
    this.bottomCount,
    this.bottomOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      child: Column(
        children: [
          _CardRow(
            text: topText,
            count: topCount,
            icon: topIcon,
            onTapped: topOnTap,
          ),
          const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 12),
          _CardRow(
            text: bottomText,
            count: bottomCount,
            icon: bottomIcon,
            onTapped: bottomOnTap,
          ),
        ],
      ),
    );
  }
}

/// A single row inside a settings card.
///
/// This is UI-only right now:
/// - counts are placeholders
/// - reminder text is placeholder
/// - onTap will later open real edit flows
class _CardRow extends StatelessWidget {
  final String text;
  final int? count;
  final IconData? icon;
  final String? reminderText;
  final VoidCallback? onTapped;

  const _CardRow({
    required this.text,
    this.count,
    this.icon,
    this.reminderText,
    this.onTapped,
  });

  static const double _rowHeight = 56;
  static const double _hPadding = 12;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Placeholder: this will open the real settings/editor screens later.
      onTap: onTapped,
      child: SizedBox(
        height: _rowHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _hPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    _IconBox(icon!),
                    const SizedBox(width: 12),
                  ],
                  Text(text, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (count != null) ...[
                    Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.more_horiz, color: Colors.white, size: 24),
                    const SizedBox(width: 6),
                  ],
                  if (reminderText != null) ...[
                    Text(
                      reminderText!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                  ],
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}