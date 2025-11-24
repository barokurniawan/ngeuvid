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
      padding: const EdgeInsets.all(10),
      color: Colors.blue[100],
      height: 80,
      child: Row(
        children: [
          const Text("Lokasi FFMPEG :"),
          const Spacer(),
          SizedBox(
            width: 220,
            child: Text(
              path == null ? "" : path.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: onPressed,
            child: const Text("Pilih"),
          )
        ],
      ),
    );
  }
}
