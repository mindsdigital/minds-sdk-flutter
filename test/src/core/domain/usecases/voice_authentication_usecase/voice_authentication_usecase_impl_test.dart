import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/repositories/minds_repository.dart';
import 'package:minds_digital/src/core/domain/usecases/voice_authentication_usecase_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import 'voice_authentication_usecase_impl_test.mocks.dart';

@GenerateMocks([MindsRepository])
void main() {
  late MockMindsRepository mockRepository;
  late VoiceAuthenticationUsecaseImpl usecase;

  setUpAll(() {
    mockRepository = MockMindsRepository();
    usecase = VoiceAuthenticationUsecaseImpl(mockRepository);
  });

  test('should return BiometricsResponse', () async {
    final request = Mocks.requestAuthOrEnrollment;
    final expectedResponse = Mocks.responseAuth;
    when(mockRepository.authentication(request)).thenAnswer((_) async => expectedResponse);

    final response = await usecase.call(request);

    expect(response, equals(expectedResponse));
    verify(mockRepository.authentication(request)).called(1);
  });
}
