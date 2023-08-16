import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../domain/usecases/convert_audio_api_usecase.dart';
import '../domain/usecases/convert_audio_to_ogg_usecase.dart';
import '../domain/usecases/delete_audio_usecase.dart';
import '../domain/usecases/fetch_audio_duration_usecase_impl.dart';
import '../helpers/constants.dart';

class RecordingState extends Equatable {
  final int recordDuration;
  final bool isRecording;
  final String? currentBlobUrl;
  const RecordingState({
    this.recordDuration = 0,
    this.isRecording = false,
    this.currentBlobUrl,
  });

  RecordingState copyWith({
    int? recordDuration,
    bool? isRecording,
    String? currentBlobUrl,
  }) {
    return RecordingState(
      recordDuration: recordDuration ?? this.recordDuration,
      isRecording: isRecording ?? this.isRecording,
      currentBlobUrl: currentBlobUrl ?? this.currentBlobUrl,
    );
  }

  @override
  List<Object?> get props => [recordDuration, isRecording, currentBlobUrl];
}

class RecordingHelper {
  ValueNotifier<RecordingState> recordState = ValueNotifier(const RecordingState());
  ConvertAudioToOggUsecase convertAudioToOggUsecase = GetIt.instance.get();
  FetchAudioDurationUsecase fetchAudioDurationUsecase = GetIt.instance.get();
  DeleteAudioUsecase deleteAudioUsecase = GetIt.instance.get();
  ConvertAudioApiUsecase convertAudioApiUsecase = GetIt.instance.get();
  Record record = Record();
  Timer? _timer;

  Future<bool> hasPermissionMic() async => await record.hasPermission();

  Future<void> startRecord() async {
    Directory? directory;
    if (!kIsWeb) {
      directory = await getTemporaryDirectory();
    } else {
      recordState.value = recordState.value.copyWith(currentBlobUrl: "");
    }
    if (await record.hasPermission()) {
      await record.start(
        path: !kIsWeb ? "${directory!.path}/${const Uuid().v4()}.m4a" : null,
        samplingRate: MindsSDKConstants.samplingRate,
        encoder: !kIsWeb ? AudioEncoder.pcm16bit : AudioEncoder.opus,
        numChannels: 1,
      );
      recordState.value = recordState.value.copyWith(recordDuration: 0);
      _startTimer();
      final isRecording = await record.isRecording();
      recordState.value = recordState.value.copyWith(isRecording: isRecording);
    }
  }

  Future<String?> _stopRecordMobile(String? path, int currentDuration) async {
    if (path != null) {
      if (minLenghtVerify(currentDuration)) {
        deleteAudioUsecase(path);
        return null;
      }
      final response = await convertAudioToOggUsecase(path);
      return response;
    }
    return null;
  }

  Future<String?> stopRecord() async {
    final currentDuration = recordState.value.recordDuration;
    _stopTimer();
    String? path = await record.stop();
    final isRecording = await record.isRecording();
    recordState.value = recordState.value.copyWith(isRecording: isRecording, currentBlobUrl: path);
    developer.log(path!);
    return _stopRecordMobile(path, currentDuration);
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

  bool minLenghtVerify(int currentDuration) {
    final duration = (currentDuration % 60);
    return duration < 5;
  }

  void dispose() {
    recordState.dispose();
    record.dispose();
    _timer?.cancel();
  }
}
