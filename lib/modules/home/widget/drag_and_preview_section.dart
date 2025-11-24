import 'dart:io';

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
    return items.isEmpty
        ? Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: onPressed, child: const Text("Pilih video")),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[100],
            child: SizedBox(
              height: 330,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items.elementAt(index);
                  final fileSize =
                      ((item.lengthSync() / 1024) / 1024).toStringAsFixed(3);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          "https://dummyimage.com/600x400/000/fff",
                          width: 140,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.path.substring(item.path.length - 35),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${fileSize}Mb",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
