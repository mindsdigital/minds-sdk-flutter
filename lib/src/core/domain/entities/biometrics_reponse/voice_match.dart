class VoiceMatch {
  final String result;
  final String confidence;
  final String status;
  const VoiceMatch({required this.result, required this.confidence, required this.status});

  @override
  String toString() => 'VoiceMatch(result: $result, confidence: $confidence, status: $status)';
}
