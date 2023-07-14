import '../entities/enrollment/enrollment_certify_request.dart';
import '../entities/enrollment/enrollment_certify_response.dart';
import '../repositories/minds_repository.dart';
import 'enrollment_certify_usecase.dart';

class EnrollmentCertifyUsecaseImpl implements EnrollmentCertifyUsecase {
  final MindsRepository _repository;

  const EnrollmentCertifyUsecaseImpl(this._repository);

  @override
  Future<EnrollmentCertifyResponse> call(EnrollmentCertifyRequest request) async {
    final response = await _repository.enrollmentCertify(request);
    return response;
  }
}
