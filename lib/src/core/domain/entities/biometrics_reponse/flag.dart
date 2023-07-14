class Flag {
  final String type;
  final String status;
  const Flag({required this.type, required this.status});

  @override
  String toString() => 'Flag(type: $type, status: $status)';
}
