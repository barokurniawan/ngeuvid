import 'package:flutter/material.dart';

class FfmpedLocationSection extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? path;

  const FfmpedLocationSection({
    super.key,
    this.onPressed,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Text('Lokasi FFMPEG'),
          const Spacer(),
          SizedBox(
            width: 230,
            child: Text(
              path ?? "",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.folder_open))
        ],
      ),
    );
  }
}
