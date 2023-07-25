import '../../domain/entities/biometrics_reponse/antispoofing.dart';

class AntiSpoofingMapper {
  static AntiSpoofing fromObject(Map<String, dynamic> map) {
    return AntiSpoofing(
      result: map['result'],
      status: map['status'],
    );
  }
}
