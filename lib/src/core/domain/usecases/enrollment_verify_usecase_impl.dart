import '../entities/enrollment/enrollment_verify_response.dart';
import '../repositories/minds_repository.dart';
import 'enrollment_verify_usecase.dart';

class EnrollmentVerifyUsecaseImpl implements EnrollmentVerifyUsecase {
  final MindsRepository _repository;

  const EnrollmentVerifyUsecaseImpl(this._repository);

  @override
  Future<EnrollmentVerifyResponse> call(String cpf) async {
    final response = await _repository.enrollmentVerify(cpf);
    return response;
  }
}
