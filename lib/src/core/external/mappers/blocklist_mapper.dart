import '../../domain/entities/blocklist/blocklist_status.dart';

class BlocklistMapper {
  static BlocklistStatus toObject(Map<String, dynamic> map) {
    return BlocklistStatus(
      id: map['id'],
      createdAt: map['created_at'],
    );
  }
}
