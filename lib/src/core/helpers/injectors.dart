import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../minds_initializer.dart';
import '../domain/repositories/minds_repository.dart';
import '../domain/usecases/convert_audio_api_usecase.dart';
import '../domain/usecases/convert_audio_api_usecase_impl.dart';
import '../domain/usecases/convert_audio_to_ogg_usecase.dart';
import '../domain/usecases/convert_audio_to_ogg_usecase_impl.dart';
import '../domain/usecases/delete_audio_usecase.dart';
import '../domain/usecases/delete_audio_usecase_impl.dart';
import '../domain/usecases/enrollment_certify_usecase.dart';
import '../domain/usecases/enrollment_certify_usecase_impl.dart';
import '../domain/usecases/enrollment_usecase.dart';
import '../domain/usecases/enrollment_usecase_impl.dart';
import '../domain/usecases/enrollment_verify_usecase.dart';
import '../domain/usecases/enrollment_verify_usecase_impl.dart';
import '../domain/usecases/fetch_audio_duration_usecase.dart';
import '../domain/usecases/fetch_audio_duration_usecase_impl.dart';
import '../domain/usecases/fetch_random_sentence_usecase.dart';
import '../domain/usecases/fetch_random_sentence_usecase_impl.dart';
import '../domain/usecases/sdk_init_validator_usecase.dart';
import '../domain/usecases/sdk_init_validator_usecase_impl.dart';
import '../domain/usecases/set_phone_blocklist_usecase.dart';
import '../domain/usecases/set_phone_blocklist_usecase_impl.dart';
import '../domain/usecases/set_voice_blocklist_usecase.dart';
import '../domain/usecases/set_voice_blocklist_usecase_impl.dart';
import '../domain/usecases/voice_authentication_usecase.dart';
import '../domain/usecases/voice_authentication_usecase_impl.dart';
import '../external/datasources/minds_remote_datasource_impl.dart';
import '../infra/datasources/minds_remote_datasource.dart';
import '../infra/repositories/minds_repository_impl.dart';
import '../service/minds_service.dart';
import '../stores/flow_biometrics/flow_biometrics_store.dart';
import 'custom_interceptors.dart';

class Injectors {
  final GetIt getIt;
  const Injectors(this.getIt);

  configure() {
    if (getIt.isRegistered<MindsService>()) {
      _uregister();
    }
    final httpClient = Dio(BaseOptions(baseUrl: MindsApiWrapper.environment!.baseUrl))
      ..interceptors.add(CustomInterceptors());

    getIt.registerFactory<MindsRemoteDataSource>(() => MindsRemoteDataSourceImpl(httpClient));

    getIt.registerFactory<MindsRepository>(() => MindsRepositoryImpl(getIt()));

    getIt
        .registerFactory<VoiceAuthenticationUsecase>(() => VoiceAuthenticationUsecaseImpl(getIt()));

    getIt.registerFactory<EnrollmentUsecase>(() => EnrollmentUsecaseImpl(getIt()));

    getIt.registerFactory<SetPhoneBlocklistUsecase>(() => SetPhoneBlocklistUsecaseImpl(getIt()));

    getIt.registerFactory<SetVoiceBlocklistUsecase>(() => SetVoiceBlocklistUsecaseImpl(getIt()));

    getIt.registerFactory<EnrollmentVerifyUsecase>(() => EnrollmentVerifyUsecaseImpl(getIt()));

    getIt.registerFactory<EnrollmentCertifyUsecase>(() => EnrollmentCertifyUsecaseImpl(getIt()));

    getIt
        .registerFactory<FetchRandomSentenceUsecase>(() => FetchRandomSentenceUsecaseImpl(getIt()));

    getIt.registerFactory<ConvertAudioToOggUsecase>(() => ConvertAudioToOggUsecaseImpl());

    getIt.registerFactory<FetchAudioDurationUsecase>(() => FetchAudioDurationUsecaseImpl());

    getIt.registerFactory<DeleteAudioUsecase>(() => DeleteAudioUsecaseImpl());

    getIt.registerFactory<ConvertAudioApiUsecase>(() => ConvertAudioApiUsecaseImpl(getIt()));

    getIt.registerFactory<SDKInitValidatorUsecase>(() => SDKInitValidatorUsecaseImpl(getIt()));

    getIt.registerFactory<MindsService>(
        () => MindsService(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));

    getIt
        .registerFactory<FlowBiometricsStore>(() => FlowBiometricsStore(getIt(), getIt(), getIt()));
  }

  _uregister() {
    getIt.unregister<MindsRemoteDataSource>();
    getIt.unregister<MindsRepository>();
    getIt.unregister<VoiceAuthenticationUsecase>();
    getIt.unregister<EnrollmentUsecase>();
    getIt.unregister<SetPhoneBlocklistUsecase>();
    getIt.unregister<SetVoiceBlocklistUsecase>();
    getIt.unregister<EnrollmentVerifyUsecase>();
    getIt.unregister<EnrollmentCertifyUsecase>();
    getIt.unregister<FetchRandomSentenceUsecase>();
    getIt.unregister<ConvertAudioToOggUsecase>();
    getIt.unregister<FetchAudioDurationUsecase>();
    getIt.unregister<DeleteAudioUsecase>();
    getIt.unregister<ConvertAudioApiUsecase>();
    getIt.unregister<SDKInitValidatorUsecase>();
    getIt.unregister<MindsService>();
    getIt.unregister<FlowBiometricsStore>();
  }
}
