import 'base_api_response.dart';

class Success extends BaseApiResponse {
  String? message;
  dynamic data;
  Success({
    required this.message,
    required this.data,
  });
}
