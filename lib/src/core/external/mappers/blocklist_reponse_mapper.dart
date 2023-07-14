import '../../domain/entities/blocklist/blocklist_reponse.dart';
import 'blocklist_mapper.dart';
import 'error_response_mapper.dart';

class BlocklistResponseMapper {
  static BlocklistResponse toObject(Map<String, dynamic> map) {
    return BlocklistResponse(
      success: map['success'],
      error: map['error'] != null ? ErrorResponseMapper.toObject(map['error']) : null,
      blocklist: map['blocklist'] != null ? BlocklistMapper.toObject(map['blocklist']) : null,
    );
  }
}
