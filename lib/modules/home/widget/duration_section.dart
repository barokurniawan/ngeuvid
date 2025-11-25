import 'package:flutter/material.dart';

class DurationSection extends StatelessWidget {
  const DurationSection({
    super.key,
    required this.segmentTimeController,
  });

  final TextEditingController segmentTimeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Text("Durasi per segment:"),
          const Spacer(),
          SizedBox(
            width: 140,
            child: TextField(
              controller: segmentTimeController,
            ),
          ),
        ],
      ),
    );
  }
}
