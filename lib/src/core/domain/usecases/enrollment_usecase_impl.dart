import '../../../../minds_digital.dart';
import '../repositories/minds_repository.dart';
import 'enrollment_usecase.dart';

class EnrollmentUsecaseImpl implements EnrollmentUsecase {
  final MindsRepository _repository;

  const EnrollmentUsecaseImpl(this._repository);

  @override
  Future<BiometricsResponse> call(BiometricsRequest request) async {
    final response = await _repository.enrollment(request);
    return response;
  }
}
