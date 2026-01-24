class MelonException implements Exception {
  String message;
  Exception? cause;

  MelonException(this.message, [this.cause]);
}
