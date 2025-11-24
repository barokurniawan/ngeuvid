import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit() : super(ProcessInitial());

  void processSplitVideos() {
    emit(OnProcessing());
  }

  void setFfmpegPath(String? path) {
    emit(OnFfmpegSelected(path));
  }

  void setVideos(List<File> files) {
    emit(OnVideoSelected(files));
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
