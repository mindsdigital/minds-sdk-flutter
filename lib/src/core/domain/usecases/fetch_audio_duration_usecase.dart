import 'package:ffmpeg_kit_flutter_audio/ffprobe_kit.dart';
import 'fetch_audio_duration_usecase_impl.dart';

class FetchAudioDurationUsecaseImpl implements FetchAudioDurationUsecase {
  @override
  Future<int> call(String filePath) async {
    try {
      final response = await FFprobeKit.getMediaInformation(filePath);
      final mediaInformation = response.getMediaInformation();
      final duration = mediaInformation?.getDuration();
      if (duration != null) {
        double durationSeconds = double.parse(duration);
        return durationSeconds.toInt();
      }
      return 0;
    } catch (error) {
      rethrow;
    }
  }
}
