import '../../../../minds_digital.dart';
import '../../domain/entities/audio/audio_convert_request.dart';
import '../../domain/entities/audio/audio_response.dart';
import '../../domain/entities/blocklist/blocklist_reponse.dart';
import '../../domain/entities/enrollment/enrollment_certify_response.dart';
import '../../domain/entities/enrollment/enrollment_verify_response.dart';
import '../../domain/entities/random_sentence/random_sentence_response.dart';
import '../../domain/entities/validator_sdk/init_validator_request.dart';
import '../../domain/entities/validator_sdk/remote_sdk_init_validator_response.dart';

abstract class MindsRemoteDataSource {
  Future<BiometricsResponse> authentication(BiometricsRequest request);
  Future<BiometricsResponse> enrollment(BiometricsRequest request);
  Future<BlocklistResponse> voiceBlocklist(RequestVoiceBlocklist request);
  Future<BlocklistResponse> phoneBlocklist(RequestPhoneBlocklist request);
  Future<EnrollmentVerifyResponse> enrollmentVerify(String cpf);
  Future<EnrollmentCertifyResponse> enrollmentCertify(EnrollmentCertifyRequest request);
  Future<RandomSentenceResponse> fetchRandomSentence();
  Future<AudioResponse> convertAudio(AudioConvertRequest request);
  Future<RemoteSDKInitValidatorResponse> initValidator(InitValidatorRequest request);
}
