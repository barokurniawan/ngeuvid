import 'dart:developer';

import 'package:flutter/material.dart';

class OutputLocationSection extends StatelessWidget {
  final String outputPath;
  final TextEditingController textEditingController;
  final void Function()? onPressed;

  const OutputLocationSection({
    super.key,
    required this.outputPath,
    required this.textEditingController,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      color: Colors.blue[100],
      child: Column(
        children: [
          Row(
            children: [
              const Text("Durasi per segment:"),
              const Spacer(),
              SizedBox(
                width: 140,
                child: TextField(controller: textEditingController),
              ),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              const Text("Lokasi Output :"),
              const Spacer(),
              Text(outputPath),
              const Spacer(),
              OutlinedButton(
                onPressed: onPressed,
                child: const Text("Pilih"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
