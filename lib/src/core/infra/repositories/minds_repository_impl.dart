import 'package:minds_digital/src/core/domain/entities/random_sentence/random_sentence_response.dart';
import 'package:minds_digital/src/core/helpers/errors/minds_failure.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../minds_digital.dart';
import '../../domain/entities/blocklist/blocklist_reponse.dart';
import '../../domain/entities/enrollment/enrollment_certify_response.dart';
import '../../domain/entities/enrollment/enrollment_verify_response.dart';
import '../datasources/minds_remote_datasource.dart';
import '../../domain/entities/biometrics_reponse/biometrics_response.dart';
import '../../domain/repositories/minds_repository.dart';

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
}
