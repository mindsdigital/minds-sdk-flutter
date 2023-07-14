import '../../domain/entities/random_sentence/random_sentence_response.dart';
import 'sentence_mapper.dart';

class RandomSentenceResponseMapper {
  static RandomSentenceResponse toObject(Map<String, dynamic> map) {
    return RandomSentenceResponse(
      sentence: SentenceMapper.toObject(map['data']),
      success: map['success'],
      message: map['message'],
      errors: map['errors'] != null ? List<String>.from(map['errors'].map((e) => e)) : [],
      requestHasValidationErrors: map['requestHasValidationErrors'],
      status: map['status'],
    );
  }
}
