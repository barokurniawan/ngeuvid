import 'package:flutter/material.dart';
import 'package:ngeuvid/modules/home/entities/selected_video.dart';

class DragAndPreviewSection extends StatelessWidget {
  final List<SelectedVideo> items;
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
                              item.duration,
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
