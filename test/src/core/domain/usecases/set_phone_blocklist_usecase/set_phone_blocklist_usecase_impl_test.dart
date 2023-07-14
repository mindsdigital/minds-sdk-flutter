import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/repositories/minds_repository.dart';
import 'package:minds_digital/src/core/domain/usecases/set_phone_blocklist_usecase_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import 'set_phone_blocklist_usecase_impl_test.mocks.dart';

@GenerateMocks([MindsRepository])
void main() {
  late MockMindsRepository mockRepository;
  late SetPhoneBlocklistUsecaseImpl usecase;

  setUpAll(() {
    mockRepository = MockMindsRepository();
    usecase = SetPhoneBlocklistUsecaseImpl(mockRepository);
  });

  test('should return BlocklistResponse', () async {
    final request = Mocks.requestPhoneBlocklist;
    final expectedResponse = Mocks.phoneBlocklistResponse;
    when(mockRepository.setPhoneBlocklist(request)).thenAnswer((_) async => expectedResponse);

    final response = await usecase.call(request);

    expect(response, equals(expectedResponse));
    verify(mockRepository.setPhoneBlocklist(request)).called(1);
  });
}
