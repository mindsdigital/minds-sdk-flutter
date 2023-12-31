import '../../domain/entities/validator_sdk/init_validator_request.dart';
import '../../helpers/constants.dart';

class InitValidatorRequestMapper {
  static Map<String, dynamic> toMap(InitValidatorRequest request) {
    return {
      "cpf": request.cpf,
      "phone_number": request.phoneNumber,
      "extension": MindsSDKConstants.defaultExtension,
      "rate": MindsSDKConstants.samplingRate,
      "check_for_verification": request.isAuthentication,
    };
  }
}
