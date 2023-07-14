import '../../domain/entities/biometrics_reponse/result.dart';

class ResultMapper {
  static Result toObject(Map<String, dynamic> map) {
    return Result(
        recommendedAction: map['recommended_action'] as String,
        reasons: map['reasons'] != null ? List<String>.from((map['reasons'])) : []);
  }
}
