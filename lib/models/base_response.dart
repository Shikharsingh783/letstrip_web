class BaseResponse<T> {
  final String? message;
  final T? data;
  final bool success; // Define 'success' as a field

  BaseResponse({
    this.message,
    this.data,
    required this.success, // Pass 'success' to the constructor
  });

  // Factory method to parse the JSON response and map to BaseResponse
  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return BaseResponse(
      message: json['message'] as String?,
      data: json.containsKey('data')
          ? json['data'] is Map<String, dynamic>
              ? fromJson(json['data'])
              : json['data'] as T
          : null,
      success: json['success'] ??
          false, // Assuming 'success' is a key in the response
    );
  }

  factory BaseResponse.fromListJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return BaseResponse(
      message: json['message'],
      data: json.containsKey('data') ? fromJsonT(json['data']) : null,
      success: json['success'] ??
          false, // Assuming 'success' is a key in the response
    );
  }
}
