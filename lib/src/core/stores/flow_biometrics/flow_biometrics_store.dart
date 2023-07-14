import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minds_digital/src/core/domain/usecases/fetch_random_sentence_usecase.dart';

import '../../domain/entities/random_sentence/random_sentence_response.dart';
import '../../presentation/helpers/base_state.dart';
part 'flow_biometrics_state.dart';

class FlowBiometricsStore extends Cubit<FlowBiometricsState> {
  final FetchRandomSentenceUsecase _fetchRandomSentenceUsecase;

  FlowBiometricsStore(this._fetchRandomSentenceUsecase) : super(const FlowBiometricsState());

  Future<void> fetchRandomSentence() async {
    emit(state.copyWith(state: const LoadingRandomSentenceState()));
    final response = await _fetchRandomSentenceUsecase();
    response.fold(
      (success) => emit(
          state.copyWith(randomSentence: success, state: const SuccessFetchRandomSentenceState())),
      (failure) => emit(state.copyWith(state: FailureFetchRandomSentenceState(failure.message))),
    );
  }
}
