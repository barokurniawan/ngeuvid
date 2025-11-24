import 'package:flutter/material.dart';

class LogOutputSection extends StatelessWidget {
  final List<String> logs;

  const LogOutputSection({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Progress",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[850],
            height: 0,
          ),
          Container(
            color: Colors.grey[900],
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: logs.length,
              itemBuilder: (_, index) {
                return Text(
                  logs[index],
                  style: TextStyle(
                      color: Colors.blue[700], fontFamily: 'monospace'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
