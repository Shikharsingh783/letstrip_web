import 'user_model.dart';

class RegistrationModel {
  RegistrationModel({required this.user, required this.token});

  final User? user;
  final String token;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      token: json["token"] ?? "",
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}
