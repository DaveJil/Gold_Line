import 'base_api_response.dart';

class Failure extends BaseApiResponse {
  String? message;
  dynamic errorData;
  Failure({
    required this.message,
    required this.errorData,
  });
}
