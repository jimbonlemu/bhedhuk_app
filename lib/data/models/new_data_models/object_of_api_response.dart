class ObjectOfApiResponse {
  bool error;
  String message;

  ObjectOfApiResponse({
    required this.error,
    required this.message,
  });

  factory ObjectOfApiResponse.fromJson(Map<String, dynamic> parsed) {
    return ObjectOfApiResponse(
      error: parsed['error'] ?? true,
      message: parsed['message'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
    };
  }
}
