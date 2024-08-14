import '../../domain/entities/validator_sdk/init_validator_request.dart';
import '../../helpers/constants.dart';

class InitValidatorRequestMapper {
  static Map<String, dynamic> toMap(InitValidatorRequest request) {
    return {
      "document": {"value": request.document},
      "phone_number": request.phoneNumber,
      "phone_country_code": request.phoneCountryCode,
      "rate": MindsSDKConstants.samplingRate,
      "check_for_verification": request.isAuthentication,
    };
  }
}
