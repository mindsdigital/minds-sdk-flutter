import '../entities/enrollment/enrollment_certify_request.dart';
import '../entities/enrollment/enrollment_certify_response.dart';

abstract class EnrollmentCertifyUsecase {
  Future<EnrollmentCertifyResponse> call(EnrollmentCertifyRequest request);
}
