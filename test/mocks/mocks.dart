import 'package:minds_digital/minds_digital.dart';
import 'package:minds_digital/src/core/domain/entities/biometrics_reponse/biometrics_response.dart';
import 'package:minds_digital/src/core/domain/entities/blocklist/blocklist_reponse.dart';
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_certify_response.dart';
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_verify_response.dart';
import 'package:minds_digital/src/core/external/mappers/biometrics_reponse_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/biometrics_request_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/blocklist_reponse_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/enrollment_certify_response_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/enrollment_verify_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/request_phone_blocklist_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/request_voice_blocklist_mapper.dart';

class Mocks {
  static final Map<String, dynamic> jsonResponseErrorEnrollmentCertify = {
    "success": false,
    "message": "Customer not found.",
    "status": "invalid_customer"
  };

  static final Map<String, dynamic> jsonResponseEnrollmentCertify = {"success": true};

  static final Map<String, dynamic> jsonResponseEnrollmentVerify = {
    "success": true,
    "enrolled": true,
    "certified": true,
    "status": "ok",
    "message": "Cliente possui cadastro com biometria certificada."
  };

  static final Map<String, dynamic> jsonRequestPhoneBlocklist = {
    "phone_number": "11111111111",
    "external_id": "123",
    "description": "foi constatado uma fraude com esse número",
    "created_by": "Vitor"
  };

  static final Map<String, dynamic> jsonResponseErrorBlocklist = {
    "success": false,
    "error": {"code": "existing_audio", "description": "Áudio já existe no banco de dados."},
  };

  static final Map<String, dynamic> jsonResponseBlocklist = {
    "success": true,
    "error": null,
    "blocklist": {"id": 1, "created_at": "2023-01-09T09:04:38"}
  };

  static final Map<String, dynamic> jsonRequestVoiceBlocklist = {
    "audio": "https://.../audio.ogg",
    "external_id": "123",
    "description": "foi constatado uma fraude com essa voz",
    "created_by": "Vitor",
    "extension": "ogg"
  };

  static final Map<String, dynamic> jsonRequestAuthOrEnrollment = {
    "audio": "https://.../audio.ogg",
    "cpf": "00000000000",
    "external_id": "123",
    "external_customer_id": "123",
    "extension": "ogg",
    "phone_number": "21981564763",
    "show_details": true
  };

  static final Map<String, dynamic> jsonResponseAuth = {
    "success": true,
    "error": null,
    "id": 4040838,
    "cpf": "00000000000",
    "external_id": "4040838",
    "created_at": "2022-09-01T20:29:14.678000",
    "result": {
      "recommended_action": "accept",
      "reasons": ["voice_match"]
    },
    "details": {
      "flag": null,
      "voice_match": {"result": "match", "confidence": "high", "status": "ok"}
    }
  };

  static final Map<String, dynamic> jsonResponseEnrollment = {
    "success": true,
    "error": null,
    "id": 4040838,
    "cpf": "00000000000",
    "external_id": "4040838",
    "created_at": "2022-09-01T20:29:14.678000",
    "result": {
      "recommended_action": "accept",
      "reasons": ["enrollment_success"]
    },
    "details": {
      "flag": null,
    }
  };

  static BiometricsResponse get responseAuth => BiometricsResponseMapper.toObject(jsonResponseAuth);

  static BiometricsRequest get requestAuthOrEnrollment =>
      BiometricsRequestMapper.toObject(jsonRequestAuthOrEnrollment);

  static RequestVoiceBlocklist get requestVoiceBlocklist =>
      RequestVoiceBlocklistMapper.toObject(jsonRequestVoiceBlocklist);

  static RequestPhoneBlocklist get requestPhoneBlocklist =>
      RequestPhoneBlocklistMapper.toObject(jsonRequestPhoneBlocklist);

  static EnrollmentCertifyRequest get requestEnrollmentCertify =>
      const EnrollmentCertifyRequest(cpf: '00000000000');

  static BlocklistResponse get phoneBlocklistResponse =>
      BlocklistResponseMapper.toObject(jsonResponseBlocklist);

  static EnrollmentVerifyResponse get enrollmentVerifyResponse =>
      EnrollmentVerifyResponseMapper.toObject(jsonResponseEnrollmentVerify);

  static EnrollmentCertifyResponse get enrollmentCertifyResponse =>
      EnrollmentCertifyResponseMapper.toObject(jsonResponseEnrollmentCertify);
}
