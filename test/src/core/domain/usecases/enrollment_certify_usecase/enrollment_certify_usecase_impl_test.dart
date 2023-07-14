import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/repositories/minds_repository.dart';
import 'package:minds_digital/src/core/domain/usecases/enrollment_certify_usecase_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import 'enrollment_certify_usecase_impl_test.mocks.dart';

@GenerateMocks([MindsRepository])
void main() {
  late MockMindsRepository mockRepository;
  late EnrollmentCertifyUsecaseImpl usecase;

  setUpAll(() {
    mockRepository = MockMindsRepository();
    usecase = EnrollmentCertifyUsecaseImpl(mockRepository);
  });

  test('should return EnrollmentCertifyResponse', () async {
    final request = Mocks.requestEnrollmentCertify;
    final expectedResponse = Mocks.enrollmentCertifyResponse;
    when(mockRepository.enrollmentCertify(request)).thenAnswer((_) async => expectedResponse);

    final response = await usecase.call(request);

    expect(response, equals(expectedResponse));
    verify(mockRepository.enrollmentCertify(request)).called(1);
  });
}
