import 'package:result_dart/result_dart.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/random_sentence/random_sentence_response.dart';
import '../repositories/minds_repository.dart';
import 'fetch_random_sentence_usecase.dart';

class FetchRandomSentenceUsecaseImpl implements FetchRandomSentenceUsecase {
  final MindsRepository _repository;

  const FetchRandomSentenceUsecaseImpl(this._repository);

  @override
  Future<Result<RandomSentenceResponse, MindsFailure>> call() async {
    final response = await _repository.fetchRandomSentence();
    return response;
  }
}
