class UserModel {
  UserModel({
    required this.user,
  });

  final User? user;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  User(
      {required this.notification,
      required this.email,
      required this.country,
      required this.currency,
      required this.fullName,
      required this.pictureUrl,
      required this.id});

  final Notification? notification;
  final String email;
  final String country;
  final Currency? currency;
  final String fullName;
  final String pictureUrl;
  final String id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        notification: json["notification"] == null
            ? null
            : Notification.fromJson(json["notification"]),
        email: json["email"] ?? "",
        country: json["country"] ?? "",
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        fullName: json["fullName"] ?? "",
        pictureUrl: json["pictureUrl"] ?? "",
        id: json["id"] ?? "");
  }

  Map<String, dynamic> toJson() => {
        "notification": notification?.toJson(),
        "email": email,
        "country": country,
        "currency": currency?.toJson(),
        "fullName": fullName,
        "pictureUrl": pictureUrl,
        "id": id
      };
}

class Currency {
  Currency({
    required this.name,
    required this.symbol,
    required this.code, // Added code property
  });

  final String name;
  final String symbol;
  final String code; // New property for currency code

  // Factory constructor to create a Currency object from JSON
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json["name"] ?? "",
      symbol: json["symbol"] ?? "",
      code: json["code"] ?? "", // Assuming 'code' is in the JSON
    );
  }

  // Method to convert the Currency object back to JSON
  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "code": code, // Include the code in the JSON map
      };
}

class Notification {
  Notification({
    required this.fcmPermission,
    required this.firebaseMessageToken,
  });

  final String fcmPermission;
  final String firebaseMessageToken;

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      fcmPermission: json["fcmPermission"] ?? "",
      firebaseMessageToken: json["firebaseMessageToken"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "fcmPermission": fcmPermission,
        "firebaseMessageToken": firebaseMessageToken,
      };
}
