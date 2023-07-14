import '../entities/biometrics_reponse/biometrics_request.dart';
import '../entities/biometrics_reponse/biometrics_response.dart';

abstract class VoiceAuthenticationUsecase {
  Future<BiometricsResponse> call(BiometricsRequest request);
}
