import 'sentence.dart';

class RandomSentenceResponse {
  final Sentence sentence;
  final bool success;
  final String message;
  final List<String> errors;
  final bool requestHasValidationErrors;
  final String status;

  const RandomSentenceResponse.empty()
      : sentence = const Sentence(id: 0, text: ""),
        success = false,
        message = "",
        errors = const [],
        requestHasValidationErrors = false,
        status = '';

  RandomSentenceResponse({
    required this.sentence,
    required this.success,
    required this.message,
    required this.errors,
    required this.requestHasValidationErrors,
    required this.status,
  });
}
