import 'package:result_dart/result_dart.dart';
import '../../../../minds_digital.dart';
import '../../domain/entities/audio/audio_convert_request.dart';
import '../../domain/entities/audio/audio_response.dart';
import '../../domain/entities/blocklist/blocklist_reponse.dart';
import '../../domain/entities/enrollment/enrollment_certify_response.dart';
import '../../domain/entities/enrollment/enrollment_verify_response.dart';
import '../../domain/entities/random_sentence/random_sentence_response.dart';
import '../../domain/entities/validator_sdk/init_validator_request.dart';
import '../../domain/entities/validator_sdk/remote_sdk_init_validator_response.dart';
import '../../domain/repositories/minds_repository.dart';
import '../../helpers/errors/minds_failure.dart';
import '../datasources/minds_remote_datasource.dart';

class MindsRepositoryImpl implements MindsRepository {
  final MindsRemoteDataSource _remoteDataSource;

  const MindsRepositoryImpl(this._remoteDataSource);

  @override
  Future<BiometricsResponse> authentication(BiometricsRequest request) async {
    try {
      final response = await _remoteDataSource.authentication(request);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BiometricsResponse> enrollment(BiometricsRequest request) async {
    try {
      final response = await _remoteDataSource.enrollment(request);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BlocklistResponse> setVoiceBlocklist(RequestVoiceBlocklist request) async {
    try {
      final response = await _remoteDataSource.voiceBlocklist(request);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BlocklistResponse> setPhoneBlocklist(RequestPhoneBlocklist request) async {
    try {
      final response = await _remoteDataSource.phoneBlocklist(request);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EnrollmentVerifyResponse> enrollmentVerify(String cpf) async {
    try {
      final response = await _remoteDataSource.enrollmentVerify(cpf);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EnrollmentCertifyResponse> enrollmentCertify(EnrollmentCertifyRequest request) async {
    try {
      final response = await _remoteDataSource.enrollmentCertify(request);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Result<RandomSentenceResponse, MindsFailure>> fetchRandomSentence() async {
    try {
      final result = await _remoteDataSource.fetchRandomSentence();
      return Success(result);
    } on MindsFailure catch (failure) {
      return Failure(failure);
    }
  }

  @override
  Future<Result<AudioResponse, MindsFailure>> convertAudio(AudioConvertRequest request) async {
    try {
      final result = await _remoteDataSource.convertAudio(request);
      return Success(result);
    } on MindsFailure catch (failure) {
      return Failure(failure);
    }
  }

  @override
  Future<Result<RemoteSDKInitValidatorResponse, MindsFailure>> initValidator(
      InitValidatorRequest request) async {
    try {
      final result = await _remoteDataSource.initValidator(request);
      return Success(result);
    } on MindsFailure catch (failure) {
      return Failure(failure);
    }
  }
}
