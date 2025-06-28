class ResetPasswordResponse {
  final dynamic data; 
  final String? message;
  final List<dynamic>? error;
  final int? status;

  ResetPasswordResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      data: json['data'], 
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data, 
      'message': message,
      'error': error,
      'status': status,
    };
  }
}
