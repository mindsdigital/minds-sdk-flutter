import '../../../../minds_digital.dart';
import '../entities/biometrics_reponse/biometrics_response.dart';

abstract class EnrollmentUsecase {
  Future<BiometricsResponse> call(BiometricsRequest request);
}
