part of 'process_cubit.dart';

sealed class ProcessState extends Equatable {
  const ProcessState();

  @override
  List<Object?> get props => [];
}

final class ProcessInitial extends ProcessState {}

final class OnProcessing extends ProcessState {}

final class OnProcessFinished extends ProcessState {}

final class OnProcessFailed extends ProcessState {
  final String errorMessage;

  const OnProcessFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class OnVideoSelected extends ProcessState {
  final List<SelectedVideo> files;

  const OnVideoSelected(this.files);

  @override
  List<Object?> get props => [files];
}

final class OnProcessingVideoSelected extends ProcessState {}

final class OnFfmpegSelected extends ProcessState {
  final String? ffmpegPath;
  final String? ffprobePath;

  const OnFfmpegSelected(this.ffmpegPath, this.ffprobePath);

  @override
  List<Object?> get props => [ffmpegPath, ffprobePath];
}

final class OnSegmentTimeChange extends ProcessState {
  final String segmentTime;

  const OnSegmentTimeChange(this.segmentTime);

  @override
  List<Object> get props => [segmentTime];
}

final class OnBroadcastMessage extends ProcessState {
  final String message;

  const OnBroadcastMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class OnOutputDirSelected extends ProcessState {
  final String path;

  const OnOutputDirSelected(this.path);

  @override
  List<Object> get props => [path];
}
