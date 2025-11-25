import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class DragAndPreviewSection extends StatelessWidget {
  final List<File> items;
  final void Function()? onPressed;

  const DragAndPreviewSection({
    super.key,
    this.onPressed,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        items.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items.elementAt(index);
                      final fileSize = ((item.lengthSync() / 1024) / 1024)
                          .toStringAsFixed(3);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "${index + 1}. ${item.path.substring(item.path.length - 35)}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${fileSize}Mb",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            : Container(),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: onPressed, child: const Text("Pilih video")),
            ],
          ),
        ),
      ],
    );
  }
}
