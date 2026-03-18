import 'package:clocked_pay/widgets/full_width_card.dart';
import 'package:flutter/material.dart';

class WeekModel extends StatefulWidget {
  final int week;
  final bool sent;
  final double amount;
  const WeekModel({
    super.key,
    required this.week,
    required this.sent,
    required this.amount,
  });

  @override
  State<WeekModel> createState() => _WeekModelState();
}

class _WeekModelState extends State<WeekModel> {
  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Week ${widget.week}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "£${widget.amount.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Feb 10 - Feb 16",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Last edited feb 13 14:12",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              StatusCard(sent: widget.sent),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final bool sent;
  const StatusCard({super.key, required this.sent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: sent == true ? Color(0x303B82F6) : Color(0x2A34C759),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          sent == true ? "Sent" : "Draft",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
