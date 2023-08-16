import 'dart:developer' as developer;
import 'dart:io';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'convert_audio_to_ogg_usecase.dart';

class ConvertAudioToOggUsecaseImpl implements ConvertAudioToOggUsecase {
  @override
  Future<String?> call(String m4aFilePath) async {
    final Directory tempDir = await getTemporaryDirectory();
    String oggPath = tempDir.path + const Uuid().v4() + ".ogg";
    final arguments = "-f s16le -ar 48000 -ac 1 -i $m4aFilePath -c:a libopus $oggPath";
    final session = await FFmpegKit.execute(arguments);
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      developer.log('Audio conversion completed successfully!');
      if (await File(m4aFilePath).exists()) {
        await File(m4aFilePath).delete();
      }
      return oggPath;
    } else {
      final failStackTrace = await session.getFailStackTrace();
      final logs = await session.getLogs();
      for (var log in logs) {
        developer.log(log.getMessage());
      }
      throw Exception(failStackTrace);
    }
  }
}
