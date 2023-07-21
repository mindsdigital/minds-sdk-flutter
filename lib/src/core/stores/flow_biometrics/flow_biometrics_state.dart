part of 'flow_biometrics_store.dart';

class LoadingRandomSentenceState extends LoadingState {
  const LoadingRandomSentenceState();
}

class SuccessFetchRandomSentenceState extends SuccessState {
  const SuccessFetchRandomSentenceState();
}

class FailureFetchRandomSentenceState extends FailureState {
  const FailureFetchRandomSentenceState(String message) : super(message);
}

class LoadingSdkInitState extends LoadingState {
  const LoadingSdkInitState();
}

class SuccessSdkInitState extends SuccessState {
  const SuccessSdkInitState();
}

class FailureSdkInitState extends FailureState {
  const FailureSdkInitState(String message) : super(message);
}

class FlowBiometricsState extends Equatable {
  final RandomSentenceResponse randomSentence;
  final BaseState state;
  const FlowBiometricsState({
    this.randomSentence = const RandomSentenceResponse.empty(),
    this.state = const InitialState(),
  });

  FlowBiometricsState copyWith({
    RandomSentenceResponse? randomSentence,
    BaseState? state,
  }) {
    return FlowBiometricsState(
      randomSentence: randomSentence ?? this.randomSentence,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [randomSentence, state];
}
