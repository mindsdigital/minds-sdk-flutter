import '../../domain/entities/biometrics_reponse/biometrics_request.dart';
import '../../helpers/constants.dart';

class BiometricsRequestMapper {
  static Map<String, dynamic> toMap(BiometricsRequest request) {
    return {
      "audio": request.audio,
      "document": {"value": request.document},
      "external_id": request.externalId,
      "external_customer_id": request.externalCustomerId,
      "extension": request.extension,
      "phone_number": request.phoneNumber,
      "show_details": request.showDetails,
      "sentence_id": request.sentenceId,
      "source_name": MindsSDKConstants.sourceName,
    };
  }

  static BiometricsRequest toObject(Map<String, dynamic> map) {
    return BiometricsRequest(
      audio: map['audio'],
      document: map['document']["value"],
      externalId: map['external_id'],
      externalCustomerId: map['external_customer_id'],
      extension: map['extension'],
      phoneNumber: map['phone_number'],
      showDetails: map['show_details'],
    );
  }
}
