import 'package:flutter_test/flutter_test.dart';
import 'package:minds_digital/src/core/domain/entities/biometrics_reponse/biometrics_response.dart';
import 'package:minds_digital/src/core/domain/entities/blocklist/blocklist_reponse.dart';
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_certify_response.dart';
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_verify_response.dart';
import 'package:minds_digital/src/core/infra/datasources/minds_remote_datasource.dart';
import 'package:minds_digital/src/core/infra/repositories/minds_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/mocks.dart';
import 'minds_repository_impl_test.mocks.dart';

@GenerateMocks([MindsRemoteDataSource])
void main() {
  late final MockMindsRemoteDataSource mockRemoteDataSource;
  late final MindsRepositoryImpl repository;

  setUpAll(() {
    mockRemoteDataSource = MockMindsRemoteDataSource();
    repository = MindsRepositoryImpl(mockRemoteDataSource);
  });

  group('BiometricsRepositoryImpl', () {
    group('authentication', () {
      test('should return BiometricsResponse on successful authentication', () async {
        when(mockRemoteDataSource.authentication(any)).thenAnswer((_) async => Mocks.responseAuth);

        final request = Mocks.requestAuthOrEnrollment;
        final result = await repository.authentication(request);

        expect(result, const TypeMatcher<BiometricsResponse>());
        verify(mockRemoteDataSource.authentication(request)).called(1);
      });

      test('should rethrow an error when remote data source throws an error', () {
        when(mockRemoteDataSource.authentication(any)).thenThrow(Exception());

        final request = Mocks.requestAuthOrEnrollment;
        expect(() => repository.authentication(request), throwsA(isInstanceOf<Exception>()));
        verify(mockRemoteDataSource.authentication(request)).called(1);
      });
    });

    group('enrollment', () {
      test('should return BiometricsResponse on successful enrollment', () async {
        when(mockRemoteDataSource.enrollment(any)).thenAnswer((_) async => Mocks.responseAuth);

        final request = Mocks.requestAuthOrEnrollment;
        final result = await repository.enrollment(request);

        expect(result, const TypeMatcher<BiometricsResponse>());
        verify(mockRemoteDataSource.enrollment(request)).called(1);
      });

      test('should rethrow an error when remote data source throws an error', () {
        when(mockRemoteDataSource.enrollment(any)).thenThrow(Exception());

        final request = Mocks.requestAuthOrEnrollment;
        expect(() => repository.enrollment(request), throwsA(isInstanceOf<Exception>()));
        verify(mockRemoteDataSource.enrollment(request)).called(1);
      });
    });

    group('setVoiceBlocklist', () {
      test('should return BlocklistResponse on successful voice blocklisting', () async {
        when(mockRemoteDataSource.voiceBlocklist(any))
            .thenAnswer((_) async => Mocks.phoneBlocklistResponse);

        final request = Mocks.requestVoiceBlocklist;
        final result = await repository.setVoiceBlocklist(request);

        expect(result, const TypeMatcher<BlocklistResponse>());
        verify(mockRemoteDataSource.voiceBlocklist(request)).called(1);
      });

      test('should rethrow an error when remote data source throws an error', () {
        when(mockRemoteDataSource.voiceBlocklist(any)).thenThrow(Exception());

        final request = Mocks.requestVoiceBlocklist;
        expect(() => repository.setVoiceBlocklist(request), throwsA(isInstanceOf<Exception>()));
        verify(mockRemoteDataSource.voiceBlocklist(request)).called(1);
      });
    });

    group('setPhoneBlocklist', () {
      test('should return BlocklistResponse on successful phone blocklisting', () async {
        when(mockRemoteDataSource.phoneBlocklist(any))
            .thenAnswer((_) async => Mocks.phoneBlocklistResponse);

        final request = Mocks.requestPhoneBlocklist;
        final result = await repository.setPhoneBlocklist(request);

        expect(result, const TypeMatcher<BlocklistResponse>());
        verify(mockRemoteDataSource.phoneBlocklist(request)).called(1);
      });

      test('should rethrow an error when remote data source throws an error', () {
        when(mockRemoteDataSource.phoneBlocklist(any)).thenThrow(Exception());

        final request = Mocks.requestPhoneBlocklist;
        expect(() => repository.setPhoneBlocklist(request), throwsA(isInstanceOf<Exception>()));
        verify(mockRemoteDataSource.phoneBlocklist(request)).called(1);
      });
    });

    group('enrollmentVerify', () {
      test('should return EnrollmentVerifyResponse on successful enrollment verification',
          () async {
        when(mockRemoteDataSource.enrollmentVerify(any))
            .thenAnswer((_) async => Mocks.enrollmentVerifyResponse);

        const cpf = '1234567890';
        final result = await repository.enrollmentVerify(cpf);

        expect(result, const TypeMatcher<EnrollmentVerifyResponse>());
        verify(mockRemoteDataSource.enrollmentVerify(cpf)).called(1);
      });

      test('should rethrow an error when remote data source throws an error', () {
        when(mockRemoteDataSource.enrollmentVerify(any)).thenThrow(Exception());

        const cpf = '1234567890';
        expect(() => repository.enrollmentVerify(cpf), throwsA(isInstanceOf<Exception>()));
        verify(mockRemoteDataSource.enrollmentVerify(cpf)).called(1);
      });
    });

    group('enrollmentCertify', () {
      test('should return EnrollmentCertifyResponse on successful enrollment certification',
          () async {
        when(mockRemoteDataSource.enrollmentCertify(any))
            .thenAnswer((_) async => Mocks.enrollmentCertifyResponse);

        final request = Mocks.requestEnrollmentCertify;
        final result = await repository.enrollmentCertify(request);

        expect(result, const TypeMatcher<EnrollmentCertifyResponse>());
        verify(mockRemoteDataSource.enrollmentCertify(request)).called(1);
      });

      test('should rethrow an error when remote data source throws an error', () {
        when(mockRemoteDataSource.enrollmentCertify(any)).thenThrow(Exception());

        final request = Mocks.requestEnrollmentCertify;
        expect(() => repository.enrollmentCertify(request), throwsA(isInstanceOf<Exception>()));
        verify(mockRemoteDataSource.enrollmentCertify(request)).called(1);
      });
    });
  });
}
