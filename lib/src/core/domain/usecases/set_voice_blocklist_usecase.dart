import '../../../../minds_digital.dart';
import '../entities/blocklist/blocklist_reponse.dart';

abstract class SetVoiceBlocklistUsecase {
  Future<BlocklistResponse> call(RequestVoiceBlocklist request);
}
