import 'package:result_dart/result_dart.dart';
import '../../helpers/errors/minds_failure.dart';
import '../entities/random_sentence/random_sentence_response.dart';

abstract class FetchRandomSentenceUsecase {
  Future<Result<RandomSentenceResponse, MindsFailure>> call();
}
