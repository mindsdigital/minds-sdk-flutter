class BlocklistStatus {
  final int id;
  final String createdAt;
  const BlocklistStatus({
    required this.id,
    required this.createdAt,
  });

  @override
  String toString() => 'BlocklistStatus(id: $id, createdAt: $createdAt)';
}
