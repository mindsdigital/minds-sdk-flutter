import '../../domain/entities/validator_sdk/remote_sdk_init_validator_response.dart';

class RemoteSdkInitValidatorResponseMapper {
  static RemoteSDKInitValidatorResponse toObject(Map<String, dynamic> map) {
    return RemoteSDKInitValidatorResponse(
      status: map['status'],
      success: map['success'],
      message: map['message'],
    );
  }
}
