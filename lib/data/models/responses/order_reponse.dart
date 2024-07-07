import 'package:dyshez_test/data/enums/response_status.dart';

class OrderResponse {
  final ResponseStatus status;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  OrderResponse({
    required this.status,
    this.data,
    this.errorMessage,
  });

  factory OrderResponse.success(Map<String, dynamic> data) {
    return OrderResponse(
      status: ResponseStatus.success,
      data: data,
    );
  }

  factory OrderResponse.error(String errorMessage) {
    return OrderResponse(
      status: ResponseStatus.error,
      errorMessage: errorMessage,
      data: null,
    );
  }
}
