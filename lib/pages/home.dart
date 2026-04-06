import 'package:clocked_pay/pages/profile.dart';
import 'package:clocked_pay/widgets/full_width_card.dart';
import 'package:clocked_pay/models/homescreenweek_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  Widget segmentText(String text, constraints, context) {
    final width = constraints.maxWidth / 3;
    return SizedBox(width: width, child: Center(child: Text(text, style: Theme.of(context).textTheme.labelMedium,)));
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedValue = "all";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0F1113),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(
                text: Text(
                  "Home",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 8),
              HeaderText(
                text: Text(
                  "Everything stays editable - even after sending.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              FullWidthCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This Week",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Feb 10 - Feb 16",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    FullWidthCard(
                      border: false,
                      color: Color(0xFF1C2127),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "£410.00 ",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              StatusCard(sent: false),
                            ],
                          ),
                          Text(
                            "Last edited today 14:41",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {

                  return CupertinoSlidingSegmentedControl<String>(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    backgroundColor: Color(0xFF1A1E22),
                    thumbColor: Color(0xFF1C2127),
                    groupValue: selectedValue,
                    children: {
                      'all': widget.segmentText("All", constraints, context),
                      'draft': widget.segmentText("Draft", constraints, context),
                      'sent': widget.segmentText("Sent", constraints, context),
                    },
                    onValueChanged: (value) {
                      setState(() => selectedValue = value!);
                    },
                  );
                },
              ),
              SizedBox(height: 12),
              Flexible(child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Column(
                      children: [
                        WeekModel(week: 6, sent: true, amount: 410),
                        SizedBox(height: 5),
                        WeekModel(week: 5, sent: true, amount: 410),
                        SizedBox(height: 5),
                        WeekModel(week: 4, sent: true, amount: 410),
                        SizedBox(height: 5),
                        WeekModel(week: 3, sent: true, amount: 410),
                        SizedBox(height: 5),
                        WeekModel(week: 2, sent: true, amount: 410),
                        SizedBox(height: 5),
                        WeekModel(week: 1, sent: true, amount: 410),
                      ],
                    ),
                  ),
                ]
              ))
            ],
          ),
        ),
      ),
    );
  }
}