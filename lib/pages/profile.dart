import 'package:clocked_pay/widgets/full_width_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:dotted_border/dotted_border.dart';

/// This file is UI-first right now.
/// I’m using these as temporary values to get the screens looking right.
/// Later I’ll replace this with real user data + persistence.
String usersName = "David Smith";
String usersCompanyName = "David Enterprises";
String usersEmail = "david@example.com";
String usersPhone = "+44 7123 456789";
String usersAddress = "123 Fake Street, London, UK";
String invoiceNumber = "INV-1001";

/// Placeholder flag while I don’t have real image upload/storage wired in yet.
bool companyImage = false;

/// Profile screen.
///
/// This is not final. At the moment:
/// - the data is coming from the placeholder variables above
/// - taps/switches are mostly just UI placeholders
/// - the real edit flows + saved settings will be wired in later
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(
                  text: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 8),
                HeaderText(
                  text: Text(
                    "Used on invoices and PDFs.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 20),

                // Top “company/account” card. This will become editable later.
                Company(
                  name: usersName,
                  companyName: usersCompanyName,
                  hasCompanyImage: companyImage,
                ),
                const SizedBox(height: 20),

                HeaderText(
                  text: Text(
                    "Information",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 6),

                // UI placeholder: rows will open editors later.
                TripleCard(
                  firstCardName: "Email",
                  firstCardInfo: usersEmail,
                  secondCardName: "Phone",
                  secondCardInfo: usersPhone,
                  thirdCardName: "Address",
                  thirdCardInfo: usersAddress,
                ),
                const SizedBox(height: 20),

                HeaderText(
                  text: Text(
                    "Signature",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 6),

                // Signature is captured here for now; save/edit flow comes later.
                const SignatureCard(),
                const SizedBox(height: 20),

                HeaderText(
                  text: Text(
                    "Preferences",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 6),

                // Switch state is local UI-only for now. This will become persisted settings.
                TripleCard(
                  firstCardName: "Invoice Numbering",
                  firstCardInfo: invoiceNumber,
                  secondCardName: "Show Logo on Invoices",
                  secondCardInfoIsSwitch: true,
                  thirdCardName: "Show Address on Invoices",
                  thirdCardInfoIsSwitch: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple 3-row card used throughout the profile screen.
/// I’m using this as a layout helper while the edit flows are still in progress.
class TripleCard extends StatelessWidget {
  final String firstCardName;
  final String? firstCardInfo;

  final String secondCardName;
  final String? secondCardInfo;
  final bool secondCardInfoIsSwitch;

  final String thirdCardName;
  final String? thirdCardInfo;
  final bool thirdCardInfoIsSwitch;

  const TripleCard({
    super.key,
    required this.firstCardName,
    this.firstCardInfo,
    required this.secondCardName,
    this.secondCardInfo,
    this.secondCardInfoIsSwitch = false,
    required this.thirdCardName,
    this.thirdCardInfo,
    this.thirdCardInfoIsSwitch = false,
  });

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      child: Column(
        children: [
          ButtonRow(text: firstCardName, info: firstCardInfo),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 12),
          const SizedBox(height: 4),
          ButtonRow(
            text: secondCardName,
            info: secondCardInfo,
            initialSwitchValue: secondCardInfoIsSwitch,
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 12),
          const SizedBox(height: 4),
          ButtonRow(
            text: thirdCardName,
            info: thirdCardInfo,
            initialSwitchValue: thirdCardInfoIsSwitch,
          ),
        ],
      ),
    );
  }
}

/// Right side of a row.
/// If I pass [info], I show text + chevron. If not, I show a switch.
///
/// Switch state is currently local to keep the UI moving.
/// I’ll replace this with real settings/state later.
class RightSideOfCard extends StatefulWidget {
  final String? info;
  final bool initialSwitchValue;

  const RightSideOfCard({
    super.key,
    this.info,
    this.initialSwitchValue = false,
  });

  @override
  State<RightSideOfCard> createState() => _RightSideOfCardState();
}

class _RightSideOfCardState extends State<RightSideOfCard> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.initialSwitchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.info != null) ...[
          Text(widget.info!, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 6),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.white,
          ),
        ] else ...[
          CupertinoSwitch(
            value: _switchValue,
            onChanged: (v) => setState(() => _switchValue = v),
            activeTrackColor: const Color(0xFF3B82F6),
            inactiveTrackColor: const Color(0xFF2A2F36),
          ),
        ],
      ],
    );
  }
}

/// A single tappable row inside a card.
/// I’m leaving [onTap] optional because navigation/edit flows are still being built.
class ButtonRow extends StatelessWidget {
  final String text;
  final String? info;
  final bool initialSwitchValue;
  final VoidCallback? onTap;

  const ButtonRow({
    super.key,
    required this.text,
    this.info,
    this.initialSwitchValue = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Placeholder: I’ll hook this up to editors / navigation later.
      onTap: onTap,
      child: SizedBox(
        height: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text, style: Theme.of(context).textTheme.headlineSmall),
              RightSideOfCard(
                info: info,
                initialSwitchValue: initialSwitchValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Company / account summary card.
/// Image handling is placeholder until I add upload/storage.
class Company extends StatelessWidget {
  final bool hasCompanyImage;
  final String name;
  final String companyName;

  const Company({
    super.key,
    required this.hasCompanyImage,
    this.name = "David Smith",
    this.companyName = "David Enterprises",
  });

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      child: InkWell(
        // Placeholder: will open edit profile/company details later.
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0x0FFFFFFF),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF20252B),
                    backgroundImage: hasCompanyImage
                        ? const AssetImage("assets/icons/people.png")
                        : null,
                    child: hasCompanyImage
                        ? null
                        : SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.asset(
                        "assets/icons/company.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 5),
                    Text(
                      companyName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

/// Signature capture card.
/// I’m only using this as a visual/interaction placeholder until I build:
/// - a full-screen signature editor
/// - clear/save actions
/// - persistence + PDF export wiring
class SignatureCard extends StatefulWidget {
  const SignatureCard({super.key});

  @override
  State<SignatureCard> createState() => _SignatureCardState();
}

class _SignatureCardState extends State<SignatureCard> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.white,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        children: [
          // The dotted border is just a UI cue that this area is editable.
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: const Radius.circular(12),
              color: const Color(0x14FFFFFF),
              dashPattern: [8, 4],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 75,
                color: const Color(0xFF20252B),
                child: Signature(
                  controller: _controller,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              "Tap to edit",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small helper I use to keep the section headers aligned.
class HeaderText extends StatelessWidget {
  final Widget text;

  const HeaderText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        text,
      ],
    );
  }
}