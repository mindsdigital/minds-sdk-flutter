import 'package:minds_digital/minds_digital.dart';
import '../entities/blocklist/blocklist_reponse.dart';
import '../repositories/minds_repository.dart';
import 'set_voice_blocklist_usecase.dart';

class SetVoiceBlocklistUsecaseImpl implements SetVoiceBlocklistUsecase {
  final MindsRepository _repository;

  const SetVoiceBlocklistUsecaseImpl(this._repository);

  @override
  Future<BlocklistResponse> call(RequestVoiceBlocklist request) async {
    final response = await _repository.setVoiceBlocklist(request);
    return response;
  }
}
