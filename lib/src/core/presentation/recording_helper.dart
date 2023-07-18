import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../domain/usecases/convert_audio_to_ogg_usecase.dart';
import 'package:record/record.dart';
import 'dart:developer' as developer;

import '../domain/usecases/delete_audio_usecase.dart';
import '../domain/usecases/fetch_audio_duration_usecase_impl.dart';

class RecordingState extends Equatable {
  final int recordDuration;
  final bool isRecording;
  const RecordingState({
    this.recordDuration = 0,
    this.isRecording = false,
  });

  RecordingState copyWith({
    int? recordDuration,
    bool? isRecording,
  }) {
    return RecordingState(
      recordDuration: recordDuration ?? this.recordDuration,
      isRecording: isRecording ?? this.isRecording,
    );
  }

  @override
  List<Object?> get props => [recordDuration, isRecording];
}

class RecordingHelper {
  Record record = Record();
  Timer? _timer;
  ValueNotifier<RecordingState> recordState = ValueNotifier(const RecordingState());
  ConvertAudioToOggUsecase convertAudioToOggUsecase =
      GetIt.instance.get<ConvertAudioToOggUsecase>();
  FetchAudioDurationUsecase fetchAudioDurationUsecase =
      GetIt.instance.get<FetchAudioDurationUsecase>();
  DeleteAudioUsecase deleteAudioUsecase = GetIt.instance.get<DeleteAudioUsecase>();

  void startRecord() async {
    final Directory directory = await getTemporaryDirectory();

    if (await record.hasPermission()) {
      await record.start(
        path: Platform.isIOS ? "${directory.path}/${const Uuid().v4()}.m4a" : null,
        samplingRate: !kIsWeb ? 48000 : 44100,
        encoder: !kIsWeb ? AudioEncoder.pcm16bit : AudioEncoder.aacLc,
        numChannels: !kIsWeb ? 1 : 2,
      );
      recordState.value = recordState.value.copyWith(recordDuration: 0);
      _startTimer();
      final isRecording = await record.isRecording();
      recordState.value = recordState.value.copyWith(isRecording: isRecording);
    }
  }

  Future<String?> stopRecord() async {
    _stopTimer();
    final path = await record.stop();
    final isRecording = await record.isRecording();
    recordState.value = recordState.value.copyWith(isRecording: isRecording);
    developer.log(path ?? "");
    if (path != null && !kIsWeb) {
      if (await fetchAudioDurationUsecase(path) < 5) {
        await deleteAudioUsecase(path);
        return null;
      }
      final response = await convertAudioToOggUsecase(path);
      return response;
    }
    return path;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int recordDuration = recordState.value.recordDuration;
      recordState.value = recordState.value.copyWith(recordDuration: recordDuration += 1);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    recordState.value = recordState.value.copyWith(recordDuration: 0);
  }

  Future<bool> isAudioLongerThan5Seconds() async {
    final duration = (recordState.value.recordDuration % 60);
    return duration > 5;
  }

  dispose() {
    recordState.dispose();
    _timer?.cancel();
    record.dispose();
  }
}
