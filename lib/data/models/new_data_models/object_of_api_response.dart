class ObjectOfApiResponse {
  bool error;
  String message;
  

  ObjectOfApiResponse({
    required this.error,
    required this.message,
  });

  factory ObjectOfApiResponse.fromJson(Map<String, dynamic> parsed) {
    return ObjectOfApiResponse(
      error: parsed['error'] ?? '',
      message: parsed['message'] ?? '',
    );
  }
}
