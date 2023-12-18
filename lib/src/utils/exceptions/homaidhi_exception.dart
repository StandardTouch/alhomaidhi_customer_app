class HomaidhiException implements Exception {
  final String status;
  final String message;

  HomaidhiException({required this.status, required this.message});

  @override
  String toString() {
    return "HomaidhiException: {status: $status, message: $message}";
  }
}
