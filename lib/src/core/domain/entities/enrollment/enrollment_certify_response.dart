class EnrollmentCertifyResponse {
  final bool success;
  final String? message;
  final String? status;
  const EnrollmentCertifyResponse({
    required this.success,
    required this.message,
    required this.status,
  });

  @override
  String toString() =>
      'EnrollmentCertifyResponse(success: $success, message: $message, status: $status)';
}
