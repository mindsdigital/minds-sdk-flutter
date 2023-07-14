import '../../../../minds_digital.dart';
import '../entities/blocklist/blocklist_reponse.dart';

abstract class SetPhoneBlocklistUsecase {
  Future<BlocklistResponse> call(RequestPhoneBlocklist request);
}
