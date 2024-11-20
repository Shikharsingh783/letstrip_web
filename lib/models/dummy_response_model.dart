class DummyResponseModel {
  late String requestId;

  DummyResponseModel({required this.requestId});

  factory DummyResponseModel.fromJson(Map<String, dynamic> json) {
    return DummyResponseModel(requestId: json["requestId"]);
  }
}
