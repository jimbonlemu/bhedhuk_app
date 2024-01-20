List<T> parser<T>(
    List<dynamic> jsonList, T Function(Map<String, dynamic>) fromJson) {
  return jsonList.map((i) => fromJson(i as Map<String, dynamic>)).toList();
}