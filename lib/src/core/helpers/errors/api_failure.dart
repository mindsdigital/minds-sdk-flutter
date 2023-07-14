import 'minds_failure.dart';

class ApiFailure extends MindsFailure {
  const ApiFailure(String message, StackTrace stackTrace) : super(message, stackTrace);
}
