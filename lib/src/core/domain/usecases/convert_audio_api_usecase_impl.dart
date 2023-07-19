import '../repositories/minds_repository.dart';
import 'package:result_dart/result_dart.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/audio/audio_convert_request.dart';
import '../entities/audio/audio_response.dart';
import 'convert_audio_api_usecase.dart';

class ConvertAudioApiUsecaseImpl implements ConvertAudioApiUsecase {
  final MindsRepository _repository;

  const ConvertAudioApiUsecaseImpl(this._repository);

  @override
  Future<Result<AudioResponse, MindsFailure>> call(AudioConvertRequest request) async {
    return await _repository.convertAudio(request);
  }
}
