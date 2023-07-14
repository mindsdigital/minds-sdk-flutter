class ErrorResponse {
  final String code;
  final String description;
  const ErrorResponse({required this.code, required this.description});

  @override
  String toString() => 'ErrorResponse(code: $code, description: $description)';
}
