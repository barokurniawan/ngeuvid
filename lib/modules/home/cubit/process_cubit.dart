import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ngeuvid/modules/home/entities/selected_video.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit() : super(ProcessInitial());

  void processSplitVideos() {
    emit(OnProcessing());
  }

  void setFfmpegPath(String? ffmpeg, String? ffprobe) {
    emit(OnFfmpegSelected(ffmpeg, ffprobe));
  }

  void setVideos(List<SelectedVideo> files) {
    emit(OnVideoSelected(files));
  }

  void setProcessingVideoSelected() {
    emit(OnProcessingVideoSelected());
  }

  void setSegmentTime(String segmentTime) {
    emit(OnSegmentTimeChange(segmentTime));
  }

  void broadcastMessage(String message) {
    emit(OnBroadcastMessage(message));
  }

  void setOnProcessing() {
    emit(OnProcessing());
  }

  void setOnProcessFinished() {
    emit(OnProcessFinished());
  }

  void setOnOutputDirSelected(String path) {
    emit(OnOutputDirSelected(path));
  }
}
