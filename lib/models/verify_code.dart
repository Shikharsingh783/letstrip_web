import 'user_model.dart';

class VerifyCodeModel {
  VerifyCodeModel({required this.token, required this.user});

  final String token;
  final User? user;

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) {
    return VerifyCodeModel(
        token: json["token"] ?? "",
        user: json["user"] == null ? null : User.fromJson(json["user"]));
  }
}
