import 'set_phone_blocklist_usecase.dart';
import '../../../../minds_digital.dart';
import '../entities/blocklist/blocklist_reponse.dart';
import '../repositories/minds_repository.dart';

class SetPhoneBlocklistUsecaseImpl implements SetPhoneBlocklistUsecase {
  final MindsRepository _repository;

  const SetPhoneBlocklistUsecaseImpl(this._repository);

  @override
  Future<BlocklistResponse> call(RequestPhoneBlocklist request) async {
    final response = await _repository.setPhoneBlocklist(request);
    return response;
  }
}
