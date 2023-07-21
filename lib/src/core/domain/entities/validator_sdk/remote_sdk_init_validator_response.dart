class RemoteSDKInitValidatorResponse {
  final String status;
  final bool success;
  final String? message;

  const RemoteSDKInitValidatorResponse({
    required this.status,
    required this.success,
    required this.message,
  });
}
