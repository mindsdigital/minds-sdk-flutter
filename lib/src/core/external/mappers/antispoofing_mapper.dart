import '../../domain/entities/biometrics_reponse/antispoofing.dart';

class AntiSpoofingMapper {
  AntiSpoofing fromObject(Map<String, dynamic> map) {
    return AntiSpoofing(
      result: map['result'],
      status: map['status'],
    );
  }
}
