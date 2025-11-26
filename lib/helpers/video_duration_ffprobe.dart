import 'dart:convert';
import 'dart:io';
import 'dart:developer';

Future<Duration> videoDurationFFProbe(
    String ffprobePath, String videoPath) async {
  final result = await Process.run(
    ffprobePath,
    [
      '-v',
      'quiet',
      '-print_format',
      'json',
      '-show_format',
      '-show_streams',
      videoPath
    ],
  );

  if (result.exitCode != 0) {
    log("FFprobe Error: ${result.stderr}");
    return Duration.zero;
  }

  final jsonData = jsonDecode(result.stdout);

  // FFprobe returns duration as string (in seconds)
  final durationStr = jsonData['format']?['duration'];

  if (durationStr == null) return Duration.zero;

  final seconds = double.tryParse(durationStr) ?? 0;

  return Duration(milliseconds: (seconds * 1000).round());
}
