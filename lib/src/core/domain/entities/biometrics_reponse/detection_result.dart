class DetectionResult {
  final String? status;
  final String? result;
  final String? confidence;
  final double? score;
  final double? threshold;

  const DetectionResult({
    required this.status,
    required this.result,
    required this.confidence,
    required this.score,
    required this.threshold,
  });

  DetectionResult.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        result = json['result'],
        confidence = json['confidence'],
        score = json['score']?.toDouble(),
        threshold = json['threshold']?.toDouble();

  @override
  String toString() {
    return 'DetectionResult(status: $status, result: $result, confidence: $confidence, score: $score, threshold: $threshold)';
  }
}
