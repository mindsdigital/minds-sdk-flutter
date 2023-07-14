import 'package:dio/dio.dart';
import 'package:minds_digital/src/core/domain/entities/random_sentence/random_sentence_response.dart';
import 'package:minds_digital/src/core/external/mappers/random_sentence_response_mapper.dart';
import 'package:minds_digital/src/core/helpers/errors/api_failure.dart';
import 'package:minds_digital/src/core/helpers/errors/datasource_failure.dart';
import '../../../../minds_digital.dart';
import '../../domain/entities/biometrics_reponse/biometrics_response.dart';
import '../../domain/entities/blocklist/blocklist_reponse.dart';
import '../../domain/entities/enrollment/enrollment_certify_response.dart';
import '../../domain/entities/enrollment/enrollment_verify_response.dart';
import '../../helpers/endpoint.dart';
import '../../infra/datasources/minds_remote_datasource.dart';
import '../mappers/biometrics_reponse_mapper.dart';
import '../mappers/biometrics_request_mapper.dart';
import '../mappers/blocklist_reponse_mapper.dart';
import '../mappers/enrollment_certify_request_mapper.dart';
import '../mappers/enrollment_certify_response_mapper.dart';
import '../mappers/enrollment_verify_mapper.dart';
import '../mappers/request_phone_blocklist_mapper.dart';
import '../mappers/request_voice_blocklist_mapper.dart';

class MindsRemoteDataSourceImpl implements MindsRemoteDataSource {
  final Dio _httpClient;

  const MindsRemoteDataSourceImpl(this._httpClient);

  @override
  Future<RandomSentenceResponse> fetchRandomSentence() async {
    try {
      final response = await _httpClient
          .get("${MindsApiWrapper.environment!.speakerUrl}${Endpoint.randomSentence}");
      return RandomSentenceResponseMapper.toObject(response.data);
    } on DioException catch (error, stackTrace) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return RandomSentenceResponseMapper.toObject(error.response?.data);
        } catch (error, stackTrace) {
          throw DatasourceFailure(error.toString(), stackTrace);
        }
      } else {
        throw ApiFailure(error.toString(), stackTrace);
      }
    } catch (error, stackTrace) {
      throw DatasourceFailure(error.toString(), stackTrace);
    }
  }

  @override
  Future<BiometricsResponse> authentication(BiometricsRequest request) async {
    try {
      final data = BiometricsRequestMapper.toMap(request);
      final response = await _httpClient.post(Endpoint.authentication, data: data);
      return BiometricsResponseMapper.toObject(response.data);
    } on DioException catch (error) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return BiometricsResponseMapper.toObject(error.response?.data);
        } catch (e) {
          rethrow;
        }
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BiometricsResponse> enrollment(BiometricsRequest request) async {
    try {
      final data = BiometricsRequestMapper.toMap(request);
      final response = await _httpClient.post(Endpoint.enrollment, data: data);
      return BiometricsResponseMapper.toObject(response.data);
    } on DioException catch (error) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return BiometricsResponseMapper.toObject(error.response?.data);
        } catch (e) {
          rethrow;
        }
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BlocklistResponse> voiceBlocklist(RequestVoiceBlocklist request) async {
    try {
      final data = RequestVoiceBlocklistMapper.toMap(request);
      final response = await _httpClient.post(Endpoint.voiceBlocklist, data: data);
      return BlocklistResponseMapper.toObject(response.data);
    } on DioException catch (error) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return BlocklistResponseMapper.toObject(error.response?.data);
        } catch (e) {
          rethrow;
        }
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BlocklistResponse> phoneBlocklist(RequestPhoneBlocklist request) async {
    try {
      final data = RequestPhoneBlocklistMapper.toMap(request);
      final response = await _httpClient.post(Endpoint.phoneBlocklist, data: data);
      return BlocklistResponseMapper.toObject(response.data);
    } on DioException catch (error) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return BlocklistResponseMapper.toObject(error.response?.data);
        } catch (e) {
          rethrow;
        }
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EnrollmentVerifyResponse> enrollmentVerify(String cpf) async {
    try {
      final response =
          await _httpClient.get(Endpoint.enrollmentVerify, queryParameters: {"cpf": cpf});
      return EnrollmentVerifyResponseMapper.toObject(response.data);
    } on DioException catch (error) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return EnrollmentVerifyResponseMapper.toObject(error.response?.data);
        } catch (e) {
          rethrow;
        }
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EnrollmentCertifyResponse> enrollmentCertify(EnrollmentCertifyRequest request) async {
    try {
      final data = EnrollmentCertifyRequestMapper.toMap(request);
      final response = await _httpClient.post(Endpoint.enrollmentCertify, data: data);
      return EnrollmentCertifyResponseMapper.toObject(response.data);
    } on DioException catch (error) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return EnrollmentCertifyResponseMapper.toObject(error.response?.data);
        } catch (e) {
          rethrow;
        }
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }
}
