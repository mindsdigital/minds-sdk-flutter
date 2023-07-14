import '../entities/biometrics_reponse/biometrics_request.dart';
import '../entities/biometrics_reponse/biometrics_response.dart';
import '../repositories/minds_repository.dart';
import 'voice_authentication_usecase.dart';

class VoiceAuthenticationUsecaseImpl implements VoiceAuthenticationUsecase {
  final MindsRepository _repository;

  const VoiceAuthenticationUsecaseImpl(this._repository);

  @override
  Future<BiometricsResponse> call(BiometricsRequest request) async {
    final response = await _repository.authentication(request);
    return response;
  }
}
