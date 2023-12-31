// Mocks generated by Mockito 5.4.2 from annotations
// in minds_digital/test/src/core/domain/usecases/set_voice_blocklist_usecase/set_voice_blocklist_usecase_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:minds_digital/minds_digital.dart' as _i8;
import 'package:minds_digital/src/core/domain/entities/biometrics_reponse/biometrics_response.dart'
    as _i2;
import 'package:minds_digital/src/core/domain/entities/blocklist/blocklist_reponse.dart'
    as _i3;
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_certify_response.dart'
    as _i5;
import 'package:minds_digital/src/core/domain/entities/enrollment/enrollment_verify_response.dart'
    as _i4;
import 'package:minds_digital/src/core/domain/repositories/minds_repository.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBiometricsResponse_0 extends _i1.SmartFake
    implements _i2.BiometricsResponse {
  _FakeBiometricsResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBlocklistResponse_1 extends _i1.SmartFake
    implements _i3.BlocklistResponse {
  _FakeBlocklistResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEnrollmentVerifyResponse_2 extends _i1.SmartFake
    implements _i4.EnrollmentVerifyResponse {
  _FakeEnrollmentVerifyResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEnrollmentCertifyResponse_3 extends _i1.SmartFake
    implements _i5.EnrollmentCertifyResponse {
  _FakeEnrollmentCertifyResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MindsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMindsRepository extends _i1.Mock implements _i6.MindsRepository {
  MockMindsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.BiometricsResponse> authentication(
          _i8.BiometricsRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #authentication,
          [request],
        ),
        returnValue:
            _i7.Future<_i2.BiometricsResponse>.value(_FakeBiometricsResponse_0(
          this,
          Invocation.method(
            #authentication,
            [request],
          ),
        )),
      ) as _i7.Future<_i2.BiometricsResponse>);
  @override
  _i7.Future<_i2.BiometricsResponse> enrollment(
          _i8.BiometricsRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #enrollment,
          [request],
        ),
        returnValue:
            _i7.Future<_i2.BiometricsResponse>.value(_FakeBiometricsResponse_0(
          this,
          Invocation.method(
            #enrollment,
            [request],
          ),
        )),
      ) as _i7.Future<_i2.BiometricsResponse>);
  @override
  _i7.Future<_i3.BlocklistResponse> setVoiceBlocklist(
          _i8.RequestVoiceBlocklist? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #setVoiceBlocklist,
          [request],
        ),
        returnValue:
            _i7.Future<_i3.BlocklistResponse>.value(_FakeBlocklistResponse_1(
          this,
          Invocation.method(
            #setVoiceBlocklist,
            [request],
          ),
        )),
      ) as _i7.Future<_i3.BlocklistResponse>);
  @override
  _i7.Future<_i3.BlocklistResponse> setPhoneBlocklist(
          _i8.RequestPhoneBlocklist? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #setPhoneBlocklist,
          [request],
        ),
        returnValue:
            _i7.Future<_i3.BlocklistResponse>.value(_FakeBlocklistResponse_1(
          this,
          Invocation.method(
            #setPhoneBlocklist,
            [request],
          ),
        )),
      ) as _i7.Future<_i3.BlocklistResponse>);
  @override
  _i7.Future<_i4.EnrollmentVerifyResponse> enrollmentVerify(String? cpf) =>
      (super.noSuchMethod(
        Invocation.method(
          #enrollmentVerify,
          [cpf],
        ),
        returnValue: _i7.Future<_i4.EnrollmentVerifyResponse>.value(
            _FakeEnrollmentVerifyResponse_2(
          this,
          Invocation.method(
            #enrollmentVerify,
            [cpf],
          ),
        )),
      ) as _i7.Future<_i4.EnrollmentVerifyResponse>);
  @override
  _i7.Future<_i5.EnrollmentCertifyResponse> enrollmentCertify(
          _i8.EnrollmentCertifyRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #enrollmentCertify,
          [request],
        ),
        returnValue: _i7.Future<_i5.EnrollmentCertifyResponse>.value(
            _FakeEnrollmentCertifyResponse_3(
          this,
          Invocation.method(
            #enrollmentCertify,
            [request],
          ),
        )),
      ) as _i7.Future<_i5.EnrollmentCertifyResponse>);
}
