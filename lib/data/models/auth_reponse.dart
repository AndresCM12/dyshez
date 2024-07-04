import 'package:dyshez_test/data/enums/response_status.dart';

class AuthResponse {
  final ResponseStatus status;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  AuthResponse({
    required this.status,
    this.data,
    this.errorMessage,
  });

  factory AuthResponse.success(Map<String, dynamic> data) {
    return AuthResponse(
      status: ResponseStatus.success,
      data: data,
    );
  }

  factory AuthResponse.error(String errorMessage) {
    return AuthResponse(
      status: ResponseStatus.error,
      errorMessage: errorMessage,
      data: null,
    );
  }
}
