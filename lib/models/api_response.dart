class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json)? fromJsonT,
  ) {
    // Add logging to inspect JSON structure
    // log('Parsing ApiResponse from JSON: $json');

    // Check for the presence of keys and log any issues
    if (!json.containsKey('success') || !json.containsKey('message')) {
      // log('Invalid JSON structure: missing keys');
      throw Exception('Invalid JSON structure');
    }

    // Parse the fields
    final bool success = json['success'] as bool;
    final String message = json['message'] as String;

    // Parse data if it exists and fromJsonT is not null
    T? data;
    if (json['data'] != null && fromJsonT != null) {
      try {
        data = fromJsonT(json['data']);
      } catch (e) {
        // log('Error parsing data: $e');
        throw Exception('Error parsing data: $e');
      }
    }

    return ApiResponse(
      success: success,
      message: message,
      data: data,
    );
  }
}
