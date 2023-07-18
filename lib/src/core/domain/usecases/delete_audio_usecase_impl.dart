import 'dart:io';
import 'dart:developer' as developer;
import 'delete_audio_usecase.dart';

class DeleteAudioUsecaseImpl implements DeleteAudioUsecase {
  @override
  Future<bool> call(String filePath) async {
    if (await File(filePath).exists()) {
      await File(filePath).delete();
      developer.log("Deleted file");
      return true;
    }
    return false;
  }
}
