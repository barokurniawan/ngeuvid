import 'package:flutter/material.dart';

class StartButtonSection extends StatelessWidget {
  final bool onProcessing;
  final void Function()? onPressed;

  const StartButtonSection({
    super.key,
    required this.onProcessing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          onProcessing
              ? const CircularProgressIndicator()
              : FilledButton(
                  onPressed: onPressed,
                  child: const Row(
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(width: 5),
                      Text("Mulai"),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
