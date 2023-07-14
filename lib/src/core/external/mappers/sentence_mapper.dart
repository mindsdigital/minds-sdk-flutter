import 'package:minds_digital/src/core/domain/entities/random_sentence/sentence.dart';

class SentenceMapper {
  static Sentence toObject(Map<String, dynamic> map) {
    return Sentence(id: map['id'], text: map['text']);
  }
}
