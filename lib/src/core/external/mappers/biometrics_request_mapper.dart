import '../../domain/entities/biometrics_reponse/biometrics_request.dart';

class BiometricsRequestMapper {
  static Map<String, dynamic> toMap(BiometricsRequest request) {
    return {
      "audio": request.audio,
      "cpf": request.cpf,
      "external_id": request.externalId,
      "external_customer_id": request.externalCustomerId,
      "extension": request.extension,
      "phone_number": request.phoneNumber,
      "show_details": request.showDetails,
    };
  }

  static BiometricsRequest toObject(Map<String, dynamic> map) {
    return BiometricsRequest(
      audio: map['audio'],
      cpf: map['cpf'],
      externalId: map['external_id'],
      externalCustomerId: map['external_customer_id'],
      extension: map['extension'],
      phoneNumber: map['phone_number'],
      showDetails: map['show_details'],
    );
  }
}
