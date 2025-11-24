import 'package:flutter/material.dart';

class ItemSelector extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final String displayValue;

  const ItemSelector({
    super.key,
    this.onPressed,
    required this.title,
    required this.displayValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Spacer(),
              onPressed != null
                  ? IconButton(
                      onPressed: onPressed, icon: const Icon(Icons.folder_open))
                  : const SizedBox(),
            ],
          ),
          Text(displayValue, textAlign: TextAlign.left),
        ],
      ),
    );
  }
}
