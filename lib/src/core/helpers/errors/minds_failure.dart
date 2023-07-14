abstract class MindsFailure {
  final String message;
  final String? code;
  final StackTrace stackTrace;

  const MindsFailure(this.message, this.stackTrace, {this.code});
}
