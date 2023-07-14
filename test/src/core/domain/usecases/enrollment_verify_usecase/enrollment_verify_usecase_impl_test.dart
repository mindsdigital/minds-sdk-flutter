import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/repositories/minds_repository.dart';
import 'package:minds_digital/src/core/domain/usecases/enrollment_verify_usecase_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';
import 'enrollment_verify_usecase_impl_test.mocks.dart';

@GenerateMocks([MindsRepository])
void main() {
  late MockMindsRepository mockRepository;
  late EnrollmentVerifyUsecaseImpl usecase;

  setUpAll(() {
    mockRepository = MockMindsRepository();
    usecase = EnrollmentVerifyUsecaseImpl(mockRepository);
  });

  test('should return EnrollmentVerifyResponse', () async {
    const request = "00000000000";
    final expectedResponse = Mocks.enrollmentVerifyResponse;
    when(mockRepository.enrollmentVerify(request)).thenAnswer((_) async => expectedResponse);
    final response = await usecase.call(request);
    expect(response, equals(expectedResponse));
    verify(mockRepository.enrollmentVerify(request)).called(1);
  });
}
