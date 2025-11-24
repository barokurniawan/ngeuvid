import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ngeuvid/main.dart';
import 'package:ngeuvid/modules/home/cubit/process_cubit.dart';
import 'package:ngeuvid/modules/home/widget/drag_and_preview_section.dart';
import 'package:ngeuvid/modules/home/widget/ffmpeg_location_section.dart';
import 'package:ngeuvid/modules/home/widget/log_output_section.dart';
import 'package:ngeuvid/modules/home/widget/output_location_section.dart';
import 'package:path/path.dart' as p;

@RoutePage()
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? ffmpegPath;
  String outputPath = "D:\\storage";
  List<File> selectedVideos = [];
  String segmentTime = "00:00:30";
  List<String> resultMessage = [];
  late TextEditingController segmentTimeController;
  final cubit = ProcessCubit();

  @override
  void initState() {
    super.initState();
    segmentTimeController = TextEditingController(text: segmentTime);

    final storage = getIt<LocalStorage>();
    storage.ready.then((value) {
      var path = storage.getItem("ffmpeg_path");
      if (path != null) {
        cubit.setFfmpegPath(path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text('NGEUVID'),
              Text(
                ' - Ngeureut Video',
                style: TextStyle(color: Color.fromARGB(255, 81, 81, 81)),
              ),
            ],
          ),
        ),
        body: BlocConsumer<ProcessCubit, ProcessState>(
          listener: processStateListener,
          builder: (context, state) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FfmpedLocationSection(
                  onPressed: () => pilihLokasiFfmpeg(cubit),
                  path: ffmpegPath,
                ),
                Divider(height: 0, color: Colors.blue[200]),
                DragAndPreviewSection(
                  items: selectedVideos,
                  onPressed: () => pilihVideo(cubit),
                ),
                Divider(height: 0, color: Colors.blue[200]),
                OutputLocationSection(
                  outputPath: outputPath,
                  textEditingController: segmentTimeController,
                  onPressed: pilihDirOutput,
                ),
                Divider(height: 0, color: Colors.blue[200]),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state is OnProcessing
                          ? const CircularProgressIndicator()
                          : FilledButton(
                              onPressed: () => runCommand(cubit),
                              child: const Row(
                                children: [
                                  Icon(Icons.play_arrow),
                                  SizedBox(width: 5),
                                  Text("Mulai"),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.blue[200]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void processStateListener(context, state) {
    if (state is OnFfmpegSelected) {
      ffmpegPath = state.path;
    }

    if (state is OnVideoSelected) {
      selectedVideos = state.files;
    }

    if (state is OnBroadcastMessage) {
      resultMessage.add(state.message);
    }

    if (state is OnProcessFinished) {
      const snackBar = SnackBar(
        content: Text('Geus beres'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (state is OnProcessFailed) {
      const snackBar = SnackBar(
        content: Text(
          'Gagal euy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (state is OnOutputDirSelected) {
      outputPath = state.path;
    }
  }

  void pilihLokasiFfmpeg(ProcessCubit cubit) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) {
      return;
    }

    final ffmpegPath = result.files.elementAt(0).path;
    final storage = getIt<LocalStorage>();
    storage.ready.then((_) => storage.setItem("ffmpeg_path", ffmpegPath));

    log("path: $ffmpegPath");
    cubit.setFfmpegPath(ffmpegPath);
  }

  Future<void> pilihVideo(ProcessCubit cubit) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) {
      return;
    }

    final files = result.files.nonNulls
        .takeWhile((value) => value.path != null)
        .map((e) => File(e.path!))
        .toList();
    log("files: ${files.length}");

    cubit.setVideos(files);
  }

  Future<void> pilihDirOutput() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result == null) {
      return;
    }

    log("Path $result");

    cubit.setOnOutputDirSelected(result);
  }

  List<List<String>> buildCommand() {
    if (outputPath == null) {
      log("Output empty");
      return [];
    }

    if (segmentTimeController.text.isEmpty) {
      return [];
    }

    final targetPath = p.join(outputPath!, "output%03d.mp4");
    return selectedVideos
        .map((e) => [
              "-i",
              e.path,
              "-c",
              "copy",
              "-map",
              "0",
              "-segment_time",
              segmentTimeController.text,
              "-f",
              "segment",
              "-reset_timestamps",
              "1",
              targetPath
            ])
        .toList();
  }

  runCommand(ProcessCubit cubit) async {
    var command = buildCommand();
    cubit.setOnProcessing();
    for (var com in command) {
      try {
        throwIf(command.isEmpty, "Command not initialized");

        // Execute a command, e.g., 'ls' on Linux/macOS or 'dir' on Windows
        // The second argument is a list of arguments for the command
        final result = await Process.run(ffmpegPath!, com);

        // Check the exit code (0 usually indicates success)
        if (result.exitCode == 0) {
          print('Command executed successfully.');
          print('Stdout: ${result.stdout}');
          print('Stderr: ${result.stderr}');
        } else {
          print('Command failed with exit code: ${result.exitCode}');
          print('Stderr: ${result.stderr}');
        }
      } catch (e) {
        print('Error executing command: $e');
      }

      cubit.setOnProcessFinished();
    }
  }
}
