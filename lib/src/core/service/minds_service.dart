import 'package:minds_digital/minds_digital.dart';
import '../domain/entities/biometrics_reponse/biometrics_response.dart';
import '../domain/entities/blocklist/blocklist_reponse.dart';
import '../domain/entities/enrollment/enrollment_certify_response.dart';
import '../domain/entities/enrollment/enrollment_verify_response.dart';
import '../domain/usecases/enrollment_certify_usecase.dart';
import '../domain/usecases/enrollment_usecase.dart';
import '../domain/usecases/enrollment_verify_usecase.dart';
import '../domain/usecases/set_phone_blocklist_usecase.dart';
import '../domain/usecases/set_voice_blocklist_usecase.dart';
import '../domain/usecases/voice_authentication_usecase.dart';

class MindsService {
  final VoiceAuthenticationUsecase _voiceAuthenticationUsecase;
  final EnrollmentUsecase _enrollmentUsecase;
  final SetPhoneBlocklistUsecase _setPhoneBlocklistUsecase;
  final SetVoiceBlocklistUsecase _setVoiceBlocklistUsecase;
  final EnrollmentCertifyUsecase _enrollmentCertifyUsecase;
  final EnrollmentVerifyUsecase _enrollmentVerifyUsecase;

  const MindsService(
    this._voiceAuthenticationUsecase,
    this._enrollmentUsecase,
    this._setPhoneBlocklistUsecase,
    this._setVoiceBlocklistUsecase,
    this._enrollmentCertifyUsecase,
    this._enrollmentVerifyUsecase,
  );

  Future<BiometricsResponse> executeProcess(
      {required ProcessType processType, required BiometricsRequest request}) async {
    final response = processType == ProcessType.authentication
        ? await _voiceAuthenticationUsecase(request)
        : await _enrollmentUsecase(request);
    return response;
  }

  Future<BiometricsResponse> authentication({required BiometricsRequest request}) async {
    final response = await _voiceAuthenticationUsecase(request);
    return response;
  }

  Future<BiometricsResponse> enrollment({required BiometricsRequest request}) async {
    final response = await _enrollmentUsecase(request);
    return response;
  }

  Future<BlocklistResponse> setPhoneBlocklist({required RequestPhoneBlocklist request}) async {
    final response = await _setPhoneBlocklistUsecase(request);
    return response;
  }

  Future<BlocklistResponse> setVoiceBlocklist({required RequestVoiceBlocklist request}) async {
    final response = await _setVoiceBlocklistUsecase(request);
    return response;
  }

  Future<EnrollmentCertifyResponse> enrollmentCertify(
      {required EnrollmentCertifyRequest request}) async {
    final response = await _enrollmentCertifyUsecase(request);
    return response;
  }

  Future<EnrollmentVerifyResponse> enrollmentVerify({required String cpf}) async {
    final response = await _enrollmentVerifyUsecase(cpf);
    return response;
  }
}
