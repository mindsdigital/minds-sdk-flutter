import '../../domain/entities/biometrics_reponse/flag.dart';

class FlagMapper {
  static Flag toObject(Map<String, dynamic> map) {
    return Flag(
      type: map['type'] as String,
      status: map['status'] as String,
    );
  }
}
