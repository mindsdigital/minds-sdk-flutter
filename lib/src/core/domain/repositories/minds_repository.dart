import 'package:result_dart/result_dart.dart';
import '../../../../minds_digital.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/audio/audio_convert_request.dart';
import '../entities/audio/audio_response.dart';
import '../entities/biometrics_reponse/biometrics_response.dart';
import '../entities/blocklist/blocklist_reponse.dart';
import '../entities/enrollment/enrollment_certify_response.dart';
import '../entities/enrollment/enrollment_verify_response.dart';
import '../entities/random_sentence/random_sentence_response.dart';

abstract class MindsRepository {
  Future<BiometricsResponse> authentication(BiometricsRequest request);
  Future<BiometricsResponse> enrollment(BiometricsRequest request);
  Future<BlocklistResponse> setVoiceBlocklist(RequestVoiceBlocklist request);
  Future<BlocklistResponse> setPhoneBlocklist(RequestPhoneBlocklist request);
  Future<EnrollmentVerifyResponse> enrollmentVerify(String cpf);
  Future<EnrollmentCertifyResponse> enrollmentCertify(EnrollmentCertifyRequest request);
  Future<Result<RandomSentenceResponse, MindsFailure>> fetchRandomSentence();
  Future<Result<AudioResponse, MindsFailure>> convertAudio(AudioConvertRequest request);
}
