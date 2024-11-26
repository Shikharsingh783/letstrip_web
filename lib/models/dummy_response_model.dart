class DummyResponseModel {
  String? requestId; // Make requestId nullable

  DummyResponseModel({this.requestId}); // Nullable constructor

  // Factory method to create DummyResponseModel from JSON
  factory DummyResponseModel.fromJson(Map<String, dynamic> json) {
    return DummyResponseModel(
      requestId: json["requestId"], // Handle missing requestId
    );
  }

  // toJson method to convert DummyResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId, // Allow null for requestId
    };
  }

  @override
  String toString() {
    return 'DummyResponseModel{requestId: $requestId}';
  }
}
