import 'package:result_dart/result_dart.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/audio/audio_convert_request.dart';
import '../entities/audio/audio_response.dart';

abstract class ConvertAudioApiUsecase {
  Future<Result<AudioResponse, MindsFailure>> call(AudioConvertRequest request);
}
