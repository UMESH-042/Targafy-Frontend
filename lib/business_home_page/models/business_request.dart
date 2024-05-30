// models/join_business_request.dart

class JoinBusinessRequest {
  final String businessCode;

  JoinBusinessRequest({required this.businessCode});

  Map<String, dynamic> toJson() {
    return {
      'businessCode': businessCode,
    };
  }
}
