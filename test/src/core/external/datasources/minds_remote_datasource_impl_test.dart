import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/entities/biometrics_reponse/biometrics_response.dart';
import 'package:minds_digital/src/core/domain/entities/blocklist/blocklist_reponse.dart';
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_certify_response.dart';
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_verify_response.dart';
import 'package:minds_digital/src/core/external/datasources/minds_remote_datasource_impl.dart';
import 'package:minds_digital/src/core/external/mappers/biometrics_request_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/enrollment_certify_request_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/request_phone_blocklist_mapper.dart';
import 'package:minds_digital/src/core/external/mappers/request_voice_blocklist_mapper.dart';
import 'package:minds_digital/src/core/helpers/endpoint.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import '../../../../mocks/mocks.dart';
import 'minds_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late final MockDio mockDio;
  late final MindsRemoteDataSourceImpl dataSource;

  setUpAll(() {
    mockDio = MockDio();
    dataSource = MindsRemoteDataSourceImpl(mockDio);
  });

  group('authentication', () {
    test('should return BiometricsResponse on successful authentication', () async {
      when(mockDio.post(Endpoint.authentication,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .thenAnswer((_) async =>
              Response(data: Mocks.jsonResponseAuth, requestOptions: RequestOptions()));

      final result = await dataSource.authentication(Mocks.requestAuthOrEnrollment);

      expect(result, const TypeMatcher<BiometricsResponse>());
      verify(mockDio.post(Endpoint.authentication,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .called(1);
    });

    test('should throw an exception on DioException', () {
      when(mockDio.post(any, data: anyNamed('data')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      expectLater(() => dataSource.authentication(Mocks.requestAuthOrEnrollment),
          throwsA(isInstanceOf<DioException>()));
      verify(mockDio.post(Endpoint.authentication,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .called(1);
    });
  });

  group('enrollment', () {
    test('should return BiometricsResponse on successful enrollment', () async {
      when(mockDio.post(Endpoint.enrollment,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .thenAnswer((_) async =>
              Response(data: Mocks.jsonResponseEnrollment, requestOptions: RequestOptions()));

      final result = await dataSource.enrollment(Mocks.requestAuthOrEnrollment);

      expect(result, const TypeMatcher<BiometricsResponse>());
      verify(mockDio.post(Endpoint.enrollment,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .called(1);
    });

    test('should throw DioException on DioException with invalid response data', () {
      when(mockDio.post(Endpoint.enrollment, data: anyNamed('data'))).thenThrow(DioException(
          response: Response(data: 'Invalid response', requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      expectLater(() => dataSource.enrollment(Mocks.requestAuthOrEnrollment),
          throwsA(isInstanceOf<DioException>()));
      verify(mockDio.post(Endpoint.enrollment,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .called(1);
    });

    test('should throw any error that is not a DioException', () {
      when(mockDio.post(Endpoint.enrollment, data: anyNamed('data'))).thenThrow(Exception());

      expectLater(() => dataSource.enrollment(Mocks.requestAuthOrEnrollment),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDio.post(Endpoint.enrollment,
              data: BiometricsRequestMapper.toMap(Mocks.requestAuthOrEnrollment)))
          .called(1);
    });
  });

  group('voiceBlocklist', () {
    test('should return BlocklistResponse on successful voice blocklisting', () async {
      when(mockDio.post(Endpoint.voiceBlocklist, data: anyNamed('data'))).thenAnswer((_) async =>
          Response(data: Mocks.jsonResponseBlocklist, requestOptions: RequestOptions()));

      final result = await dataSource.voiceBlocklist(Mocks.requestVoiceBlocklist);

      expect(result, const TypeMatcher<BlocklistResponse>());
      verify(mockDio.post(Endpoint.voiceBlocklist,
              data: RequestVoiceBlocklistMapper.toMap(Mocks.requestVoiceBlocklist)))
          .called(1);
    });

    test('should throw BlocklistResponse on DioException with valid response data', () async {
      when(mockDio.post(Endpoint.voiceBlocklist, data: anyNamed('data'))).thenThrow(DioException(
          response:
              Response(data: Mocks.jsonResponseErrorBlocklist, requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      final result = await dataSource.voiceBlocklist(Mocks.requestVoiceBlocklist);

      expect(result, const TypeMatcher<BlocklistResponse>());

      verify(mockDio.post(Endpoint.voiceBlocklist,
              data: RequestVoiceBlocklistMapper.toMap(Mocks.requestVoiceBlocklist)))
          .called(1);
    });

    test('should throw DioException on DioException with invalid response data', () {
      when(mockDio.post(Endpoint.voiceBlocklist, data: anyNamed('data'))).thenThrow(DioException(
          response: Response(data: 'Invalid response', requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      expectLater(() => dataSource.voiceBlocklist(Mocks.requestVoiceBlocklist),
          throwsA(isInstanceOf<DioException>()));
      verify(mockDio.post(Endpoint.voiceBlocklist,
              data: RequestVoiceBlocklistMapper.toMap(Mocks.requestVoiceBlocklist)))
          .called(1);
    });

    test('should throw any error that is not a DioException', () {
      when(mockDio.post(Endpoint.voiceBlocklist, data: anyNamed('data'))).thenThrow(Exception());

      expectLater(() => dataSource.voiceBlocklist(Mocks.requestVoiceBlocklist),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDio.post(Endpoint.voiceBlocklist,
              data: RequestVoiceBlocklistMapper.toMap(Mocks.requestVoiceBlocklist)))
          .called(1);
    });
  });

  group('phoneBlocklist', () {
    test('should return BlocklistResponse on successful phone blocklisting', () async {
      when(mockDio.post(Endpoint.phoneBlocklist, data: anyNamed('data'))).thenAnswer((_) async =>
          Response(data: Mocks.jsonResponseBlocklist, requestOptions: RequestOptions()));

      final result = await dataSource.phoneBlocklist(Mocks.requestPhoneBlocklist);

      expect(result, const TypeMatcher<BlocklistResponse>());
      verify(mockDio.post(Endpoint.phoneBlocklist,
              data: RequestPhoneBlocklistMapper.toMap(Mocks.requestPhoneBlocklist)))
          .called(1);
    });

    test('should throw BlocklistResponse on DioException with valid response data', () async {
      when(mockDio.post(Endpoint.phoneBlocklist, data: anyNamed('data'))).thenThrow(DioException(
          response:
              Response(data: Mocks.jsonResponseErrorBlocklist, requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      final result = await dataSource.phoneBlocklist(Mocks.requestPhoneBlocklist);

      expect(result, const TypeMatcher<BlocklistResponse>());
      verify(mockDio.post(Endpoint.phoneBlocklist,
              data: RequestPhoneBlocklistMapper.toMap(Mocks.requestPhoneBlocklist)))
          .called(1);
    });

    test('should throw DioException on DioException with invalid response data', () {
      when(mockDio.post(Endpoint.phoneBlocklist, data: anyNamed('data'))).thenThrow(DioException(
          response: Response(data: 'Invalid response', requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      expect(() => dataSource.phoneBlocklist(Mocks.requestPhoneBlocklist),
          throwsA(const TypeMatcher<DioException>()));
      verify(mockDio.post(Endpoint.phoneBlocklist,
              data: RequestPhoneBlocklistMapper.toMap(Mocks.requestPhoneBlocklist)))
          .called(1);
    });

    test('should throw any error that is not a DioException', () {
      when(mockDio.post(Endpoint.phoneBlocklist, data: anyNamed('data'))).thenThrow(Exception());

      expect(() => dataSource.phoneBlocklist(Mocks.requestPhoneBlocklist),
          throwsA(const TypeMatcher<Exception>()));
      verify(mockDio.post(Endpoint.phoneBlocklist,
              data: RequestPhoneBlocklistMapper.toMap(Mocks.requestPhoneBlocklist)))
          .called(1);
    });
  });

  group('enrollmentVerify', () {
    test('should return EnrollmentVerifyResponse on successful enrollment verification', () async {
      when(mockDio.get(Endpoint.enrollmentVerify, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async =>
              Response(data: Mocks.jsonResponseEnrollmentVerify, requestOptions: RequestOptions()));

      final result = await dataSource.enrollmentVerify('1234567890');

      expect(result, const TypeMatcher<EnrollmentVerifyResponse>());
      verify(mockDio.get(Endpoint.enrollmentVerify, queryParameters: {"cpf": '1234567890'}))
          .called(1);
    });

    test('should throw DioException on DioException with invalid response data', () {
      when(mockDio.get(Endpoint.enrollmentVerify, queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
              response: Response(data: 'Invalid response', requestOptions: RequestOptions()),
              requestOptions: RequestOptions()));

      expectLater(
          () => dataSource.enrollmentVerify('1234567890'), throwsA(isInstanceOf<DioException>()));
      verify(mockDio.get(Endpoint.enrollmentVerify, queryParameters: {"cpf": '1234567890'}))
          .called(1);
    });

    test('should throw any error that is not a DioException', () {
      when(mockDio.get(Endpoint.enrollmentVerify, queryParameters: anyNamed('queryParameters')))
          .thenThrow(Exception());

      expectLater(
          () => dataSource.enrollmentVerify('1234567890'), throwsA(isInstanceOf<Exception>()));
      verify(mockDio.get(Endpoint.enrollmentVerify, queryParameters: {"cpf": '1234567890'}))
          .called(1);
    });
  });

  group('enrollmentCertify', () {
    test('should return EnrollmentCertifyResponse on successful enrollment certification',
        () async {
      when(mockDio.post(Endpoint.enrollmentCertify, data: anyNamed('data'))).thenAnswer((_) async =>
          Response(data: Mocks.jsonResponseEnrollmentCertify, requestOptions: RequestOptions()));

      final result = await dataSource.enrollmentCertify(Mocks.requestEnrollmentCertify);

      expect(result, const TypeMatcher<EnrollmentCertifyResponse>());
      verify(mockDio.post(Endpoint.enrollmentCertify,
              data: EnrollmentCertifyRequestMapper.toMap(Mocks.requestEnrollmentCertify)))
          .called(1);
    });

    test('should throw EnrollmentCertifyResponse on DioException with valid response data',
        () async {
      when(mockDio.post(Endpoint.enrollmentCertify, data: anyNamed('data'))).thenThrow(DioException(
          response: Response(
              data: Mocks.jsonResponseErrorEnrollmentCertify, requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      final result = await dataSource.enrollmentCertify(Mocks.requestEnrollmentCertify);

      expect(result, const TypeMatcher<EnrollmentCertifyResponse>());

      verify(mockDio.post(Endpoint.enrollmentCertify,
              data: EnrollmentCertifyRequestMapper.toMap(Mocks.requestEnrollmentCertify)))
          .called(1);
    });

    test('should throw DioException on DioException with invalid response data', () {
      when(mockDio.post(Endpoint.enrollmentCertify, data: anyNamed('data'))).thenThrow(DioException(
          response: Response(data: 'Invalid response', requestOptions: RequestOptions()),
          requestOptions: RequestOptions()));

      expectLater(() => dataSource.enrollmentCertify(Mocks.requestEnrollmentCertify),
          throwsA(isInstanceOf<DioException>()));
      verify(mockDio.post(Endpoint.enrollmentCertify,
              data: EnrollmentCertifyRequestMapper.toMap(Mocks.requestEnrollmentCertify)))
          .called(1);
    });

    test('should throw any error that is not a DioException', () {
      when(mockDio.post(Endpoint.enrollmentCertify, data: anyNamed('data'))).thenThrow(Exception());

      expectLater(() => dataSource.enrollmentCertify(Mocks.requestEnrollmentCertify),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDio.post(Endpoint.enrollmentCertify,
              data: EnrollmentCertifyRequestMapper.toMap(Mocks.requestEnrollmentCertify)))
          .called(1);
    });
  });
}
