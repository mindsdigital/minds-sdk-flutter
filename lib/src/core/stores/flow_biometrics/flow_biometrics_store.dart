import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:minds_digital/src/core/domain/entities/biometrics_reponse/biometrics_response.dart';
import 'package:minds_digital/src/core/domain/usecases/fetch_random_sentence_usecase.dart';

import '../../../../minds_digital.dart';
import '../../domain/entities/random_sentence/random_sentence_response.dart';
import '../../domain/usecases/delete_audio_usecase.dart';
import '../../presentation/helpers/base_state.dart';
part 'flow_biometrics_state.dart';

class FlowBiometricsStore extends Cubit<FlowBiometricsState> {
  final FetchRandomSentenceUsecase _fetchRandomSentenceUsecase;
  final DeleteAudioUsecase _deleteAudioUsecase;

  FlowBiometricsStore(this._fetchRandomSentenceUsecase, this._deleteAudioUsecase)
      : super(const FlowBiometricsState());

  Future<void> fetchRandomSentence() async {
    emit(state.copyWith(state: const LoadingRandomSentenceState()));
    final response = await _fetchRandomSentenceUsecase();
    response.fold(
      (success) => emit(
          state.copyWith(randomSentence: success, state: const SuccessFetchRandomSentenceState())),
      (failure) => emit(state.copyWith(state: FailureFetchRandomSentenceState(failure.message))),
    );
  }

  Future<BiometricsResponse> sendAudio({
    required BiometricsRequest request,
    required ProcessType processType,
    required String path,
  }) async {
    try {
      emit(state.copyWith(state: const LoadingState()));
      final response =
          await MindsApiWrapper.service.executeProcess(processType: processType, request: request);
      emit(state.copyWith(state: const SuccessState()));
      if (!kIsWeb) {
        _deleteAudioUsecase(path);
      }
      return response;
    } catch (e) {
      emit(state.copyWith(state: FailureState(e.toString())));
      rethrow;
    }
  }
}
