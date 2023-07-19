import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:minds_digital/src/core/domain/entities/audio/audio_convert_request.dart';
import 'package:minds_digital/src/core/domain/usecases/convert_audio_api_usecase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../domain/usecases/convert_audio_to_ogg_usecase.dart';
import 'package:record/record.dart';
import 'dart:developer' as developer;
import '../domain/usecases/delete_audio_usecase.dart';
import '../domain/usecases/delete_local_blob_audio_usecase.dart';
import '../domain/usecases/fetch_audio_duration_usecase_impl.dart';
import '../domain/usecases/fetch_base64_html_blob_usecase.dart';

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
  FetchBase64HtmlBlobUsecase fetchBase64HtmlBlobUsecase =
      GetIt.instance.get<FetchBase64HtmlBlobUsecase>();
  ConvertAudioApiUsecase convertAudioApiUsecase = GetIt.instance.get<ConvertAudioApiUsecase>();

  DeleteLocalBlobUsecase deleteLocalBlobUsecase = GetIt.instance.get<DeleteLocalBlobUsecase>();

  Future<void> startRecord() async {
    Directory? directory;
    if (!kIsWeb) {
      directory = await getTemporaryDirectory();
    }
    if (await record.hasPermission()) {
      await record.start(
        path: !kIsWeb ? "${directory!.path}/${const Uuid().v4()}.m4a" : null,
        samplingRate: 48000,
        encoder: !kIsWeb ? AudioEncoder.pcm16bit : AudioEncoder.opus,
        numChannels: 1,
      );
      recordState.value = recordState.value.copyWith(recordDuration: 0);
      _startTimer();
      final isRecording = await record.isRecording();
      recordState.value = recordState.value.copyWith(isRecording: isRecording);
    }
  }

  Future<void> _stopRecordWeb() async {}

  Future<void> _stopRecordMobile() async {}

  Future<String?> stopRecord() async {
    // if (kIsWeb) {
    //   _stopRecordWeb();
    // } else {
    //   _stopRecordMobile();
    // }
    final currentDuration = recordState.value.recordDuration;
    _stopTimer();
    String? path = await record.stop();
    final isRecording = await record.isRecording();
    recordState.value = recordState.value.copyWith(isRecording: isRecording);
    developer.log(path ?? "");

    if (path != null) {
      if ((currentDuration % 60) < 5) {
        if (kIsWeb) {
          deleteLocalBlobUsecase(path);
        } else {
          await deleteAudioUsecase(path);
        }
        return null;
      }

      if (!kIsWeb) {
        final response = await convertAudioToOggUsecase(path);
        return response;
      }
    }

    final base64 = await fetchBase64HtmlBlobUsecase(path ?? "");

    if (base64 != null) {
      final response = await convertAudioApiUsecase(
        AudioConvertRequest(audio: base64, format: 'webm', nextFormat: 'wav'),
      );
      response.fold(
        (result) {
          path = result.audio;
        },
        (failure) {},
      );
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

  void dispose() {
    recordState.dispose();
    _timer?.cancel();
    record.dispose();
  }
}
