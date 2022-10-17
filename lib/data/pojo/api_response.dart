class ApiResponse {
  static const String statusKey = "status";
  static const String successKey = "success";
  static const String messageKey = "message";
  static const String dataKey = "data";

  final String status;
  final bool success;
  final String? message;
  final dynamic data;

  ApiResponse(
      {required this.status,
      required this.success,
      required this.message,
      required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json[statusKey],
      success: json[successKey],
      message: json[messageKey],
      data: json[dataKey],
    );
  }
}
