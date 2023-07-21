import '../../../../minds_digital.dart';

abstract class EnrollmentUsecase {
  Future<BiometricsResponse> call(BiometricsRequest request);
}
