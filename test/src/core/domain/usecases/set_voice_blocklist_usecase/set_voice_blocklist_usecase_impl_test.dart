import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/repositories/minds_repository.dart';
import 'package:minds_digital/src/core/domain/usecases/set_voice_blocklist_usecase_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import 'set_voice_blocklist_usecase_impl_test.mocks.dart';

@GenerateMocks([MindsRepository])
void main() {
  late MockMindsRepository mockRepository;
  late SetVoiceBlocklistUsecaseImpl usecase;

  setUp(() {
    mockRepository = MockMindsRepository();
    usecase = SetVoiceBlocklistUsecaseImpl(mockRepository);
  });

  test('should return BlocklistResponse', () async {
    final request = Mocks.requestVoiceBlocklist;
    final expectedResponse = Mocks.phoneBlocklistResponse;
    when(mockRepository.setVoiceBlocklist(request)).thenAnswer((_) async => expectedResponse);

    final response = await usecase.call(request);

    expect(response, equals(expectedResponse));
    verify(mockRepository.setVoiceBlocklist(request)).called(1);
  });
}
