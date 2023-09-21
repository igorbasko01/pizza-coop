class Result<T> {
  final T? value;
  final Exception? exception;

  Result.success(this.value) : exception = null;
  Result.failure(this.exception) : value = null;

  bool get isSuccess => exception == null;
  bool get isFailure => !isSuccess;
}