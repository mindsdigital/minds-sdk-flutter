class Result {
  final String recommendedAction;
  final List<String> reasons;
  const Result({required this.recommendedAction, required this.reasons});

  @override
  String toString() => 'Result(recommendedAction: $recommendedAction, reasons: $reasons)';
}
