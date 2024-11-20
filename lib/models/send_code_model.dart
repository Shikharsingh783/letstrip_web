class SendCodeModel {
  SendCodeModel({
    required this.token,
  });

  final String token;

  factory SendCodeModel.fromJson(Map<String, dynamic> json) {
    return SendCodeModel(token: json["token"] ?? "");
  }
}
