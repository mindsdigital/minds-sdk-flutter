class AudioResponse {
  final bool success;
  final String status;
  final String audio;
  final String format;
  const AudioResponse({
    required this.success,
    required this.status,
    required this.audio,
    required this.format,
  });
}
