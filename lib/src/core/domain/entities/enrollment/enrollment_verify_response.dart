class EnrollmentVerifyResponse {
  final bool success;
  final bool enrolled;
  final bool certified;
  final String status;
  final String message;
  const EnrollmentVerifyResponse({
    required this.success,
    required this.enrolled,
    required this.certified,
    required this.status,
    required this.message,
  });

  @override
  String toString() {
    return 'EnrollmentVerifyResponse(success: $success, enrolled: $enrolled, certified: $certified, status: $status, message: $message)';
  }
}
