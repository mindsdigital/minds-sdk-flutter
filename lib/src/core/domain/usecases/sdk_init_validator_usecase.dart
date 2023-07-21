import 'package:result_dart/result_dart.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/validator_sdk/init_validator_request.dart';
import '../entities/validator_sdk/remote_sdk_init_validator_response.dart';

abstract class SDKInitValidatorUsecase {
  Future<Result<RemoteSDKInitValidatorResponse, MindsFailure>> call(InitValidatorRequest request);
}
