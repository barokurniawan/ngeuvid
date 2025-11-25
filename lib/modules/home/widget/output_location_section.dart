import 'package:flutter/material.dart';

class OutputLocationSection extends StatelessWidget {
  final String outputPath;
  final void Function()? onPressed;

  const OutputLocationSection({
    super.key,
    required this.outputPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Lokasi Output :"),
              const Spacer(),
              SizedBox(
                width: 230,
                child: Text(
                  outputPath,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.folder_open),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
