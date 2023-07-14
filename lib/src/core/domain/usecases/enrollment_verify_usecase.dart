import '../entities/enrollment/enrollment_verify_response.dart';

abstract class EnrollmentVerifyUsecase {
  Future<EnrollmentVerifyResponse> call(String cpf);
}
