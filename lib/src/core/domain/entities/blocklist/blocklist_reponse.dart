import '../biometrics_reponse/error_response.dart';
import 'blocklist_status.dart';

class BlocklistResponse {
  final bool success;
  final ErrorResponse? error;
  final BlocklistStatus? blocklist;
  BlocklistResponse({
    required this.success,
    this.error,
    required this.blocklist,
  });

  @override
  String toString() => 'BlocklistResponse(success: $success, error: $error, blocklist: $blocklist)';
}
