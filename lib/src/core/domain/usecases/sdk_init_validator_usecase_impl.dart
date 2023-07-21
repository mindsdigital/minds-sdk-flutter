import 'package:result_dart/result_dart.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/validator_sdk/init_validator_request.dart';
import '../entities/validator_sdk/remote_sdk_init_validator_response.dart';
import '../repositories/minds_repository.dart';
import 'sdk_init_validator_usecase.dart';

class SDKInitValidatorUsecaseImpl implements SDKInitValidatorUsecase {
  final MindsRepository _repository;

  const SDKInitValidatorUsecaseImpl(this._repository);

  @override
  Future<Result<RemoteSDKInitValidatorResponse, MindsFailure>> call(
      InitValidatorRequest request) async {
    return await _repository.initValidator(request);
  }
}
