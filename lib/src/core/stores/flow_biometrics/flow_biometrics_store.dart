import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:minds_digital/src/core/domain/usecases/sdk_init_validator_usecase.dart';
import '../../../../minds_digital.dart';
import '../../domain/entities/random_sentence/random_sentence_response.dart';
import '../../domain/entities/validator_sdk/init_validator_request.dart';
import '../../domain/usecases/delete_audio_usecase.dart';
import '../../domain/usecases/delete_local_blob_audio_usecase.dart';
import '../../domain/usecases/fetch_random_sentence_usecase.dart';
import '../../presentation/helpers/base_state.dart';
part 'flow_biometrics_state.dart';

class FlowBiometricsStore extends Cubit<FlowBiometricsState> {
  final FetchRandomSentenceUsecase _fetchRandomSentenceUsecase;
  final DeleteAudioUsecase _deleteAudioUsecase;
  final DeleteLocalBlobUsecase _deleteLocalBlobUsecase;
  final SDKInitValidatorUsecase _sdkInitValidatorUsecase;

  FlowBiometricsStore(
    this._fetchRandomSentenceUsecase,
    this._deleteAudioUsecase,
    this._deleteLocalBlobUsecase,
    this._sdkInitValidatorUsecase,
  ) : super(const FlowBiometricsState());

  Future<void> sdkInitValidator(InitValidatorRequest request) async {
    emit(state.copyWith(state: const LoadingSdkInitState()));
    final response = await _sdkInitValidatorUsecase(request);
    response.fold(
      (success) {
        if (success.success) {
          emit(state.copyWith(state: const SuccessSdkInitState()));
        } else {
          emit(state.copyWith(state: FailureSdkInitState(success.message!)));
        }
      },
      (failure) => emit(state.copyWith(state: FailureSdkInitState(failure.message))),
    );
  }

  setLoading(bool value) {
    emit(state.copyWith(state: value ? const LoadingState() : const UpdateState()));
  }

  Future<void> fetchRandomSentence() async {
    emit(state.copyWith(state: const LoadingRandomSentenceState()));
    final response = await _fetchRandomSentenceUsecase();
    response.fold(
      (success) => emit(
          state.copyWith(randomSentence: success, state: const SuccessFetchRandomSentenceState())),
      (failure) => emit(state.copyWith(state: FailureFetchRandomSentenceState(failure.message))),
    );
  }

  void deleteLocalAudio(String path) {
    if (kIsWeb) {
      _deleteLocalBlobUsecase(path);
    } else {
      _deleteAudioUsecase(path);
    }
  }

  Future<BiometricsResponse> sendAudio({
    required BiometricsRequest request,
    required ProcessType processType,
    required String path,
    required String? currentBlobUrl,
  }) async {
    try {
      emit(state.copyWith(state: const LoadingState()));
      final response = await MindsApiWrapper.service.executeProcess(
        processType: processType,
        request: request,
      );
      emit(state.copyWith(state: const SuccessState()));
      deleteLocalAudio(kIsWeb ? currentBlobUrl! : path);
      return response;
    } catch (e) {
      deleteLocalAudio(kIsWeb ? currentBlobUrl! : path);
      emit(state.copyWith(state: FailureState(e.toString())));
      rethrow;
    }
  }
}
