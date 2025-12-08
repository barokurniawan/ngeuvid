import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ngeuvid/helpers/format_duration.dart';
import 'package:ngeuvid/helpers/slugify.dart';
import 'package:ngeuvid/helpers/video_duration_ffprobe.dart';
import 'package:ngeuvid/main.dart';
import 'package:ngeuvid/modules/home/cubit/process_cubit.dart';
import 'package:ngeuvid/modules/home/entities/selected_video.dart';
import 'package:ngeuvid/modules/home/widget/drag_and_preview_section.dart';
import 'package:ngeuvid/modules/home/widget/duration_section.dart';
import 'package:ngeuvid/modules/home/widget/ffmpeg_location_section.dart';
import 'package:ngeuvid/modules/home/widget/output_location_section.dart';
import 'package:ngeuvid/modules/home/widget/start_button_section.dart';
import 'package:path/path.dart' as p;

@RoutePage()
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? ffmpegPath;
  String? ffprobePath;
  String outputPath = "D:\\storage";
  List<SelectedVideo> selectedVideos = [];
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
      var ffmpeg = storage.getItem("ffmpeg_path");
      var ffprobe = storage.getItem("ffprobe_path");
      if (ffmpeg != null) {
        cubit.setFfmpegPath(ffmpeg, ffprobe);
      }

      var path = storage.getItem("output_path");
      if (path != null) {
        cubit.setOnOutputDirSelected(path);
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
          builder: (context, state) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 460,
                child: Column(
                  children: [
                    FfmpedLocationSection(
                      onPressed: () => pilihLokasiFfmpeg(cubit),
                      path: ffmpegPath,
                    ),
                    DurationSection(
                      segmentTimeController: segmentTimeController,
                    ),
                    OutputLocationSection(
                      outputPath: outputPath,
                      onPressed: pilihDirOutput,
                    ),
                    StartButtonSection(
                      onPressed: () => runCommand(cubit),
                      onProcessing: state is OnProcessing,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                color: const Color.fromARGB(255, 74, 74, 74),
              ),
              SizedBox(
                width: 460,
                child: Column(
                  children: [
                    state is OnProcessingVideoSelected
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : DragAndPreviewSection(
                            items: selectedVideos,
                            onPressed: () => pilihVideo(cubit),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void processStateListener(context, state) {
    if (state is OnFfmpegSelected) {
      ffmpegPath = state.ffmpegPath;
      ffprobePath = state.ffprobePath;
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
    final result = await FilePicker.platform.getDirectoryPath();
    if (result == null) {
      return;
    }

    var ffmpegExePath = p.join(result, "ffmpeg.exe");
    var ffprobeExePath = p.join(result, "ffprobe.exe");
    if (Platform.isLinux) {
      ffmpegExePath = p.join(result, "ffmpeg");
      ffprobeExePath = p.join(result, "ffprobe");
    }

    final ffmpegPath = p.join(result, ffmpegExePath);
    final ffprobePath = p.join(result, ffprobeExePath);
    final storage = getIt<LocalStorage>();
    storage.ready.then((_) {
      storage.setItem("ffmpeg_path", ffmpegPath);
      storage.setItem("ffprobe_path", ffprobePath);
    });

    cubit.setFfmpegPath(ffmpegPath, ffprobePath);
  }

  Future<void> pilihVideo(ProcessCubit cubit) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );
    if (result == null) {
      return;
    }

    if (ffprobePath == null || ffprobePath!.isEmpty) {
      return;
    }

    cubit.setProcessingVideoSelected();

    final files = result.files.nonNulls
        .takeWhile((value) => value.path != null)
        .map((e) => File(e.path!))
        .toList();
    if (files.isEmpty) {
      return;
    }

    List<SelectedVideo> vids = [];
    for (var file in files) {
      final vidDuration = await videoDurationFFProbe(ffprobePath!, file.path);
      vids.add(
        SelectedVideo(
          path: file.path,
          duration: formatDuration(vidDuration),
        ),
      );
    }

    cubit.setVideos(vids);
  }

  Future<void> pilihDirOutput() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result == null) {
      return;
    }

    final storage = getIt<LocalStorage>();
    storage.ready.then((_) => storage.setItem("output_path", result));
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

    final List<List<String>> coms = [];
    for (var vid in selectedVideos) {
      final vidFilename = File(vid.path).uri.pathSegments.last;
      final vidPath = Directory(p.join(outputPath!, slugify(vidFilename)));
      if (!vidPath.existsSync()) {
        vidPath.createSync(recursive: true);
      }

      final targetPath = p.join(vidPath.path, "output%03d.mp4");
      coms.add([
        "-i",
        vid.path,
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
      ]);
    }

    return coms;
  }

  runCommand(ProcessCubit cubit) async {
    var command = buildCommand();
    if (selectedVideos.isEmpty) {
      return;
    }

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
