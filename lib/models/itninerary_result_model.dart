import 'package:unsplash_client/unsplash_client.dart';

class ItineraryResultModel {
  ItineraryResultModel({
    this.day,
    this.activityName,
    this.time,
    this.reason,
    this.ticketLink,
    this.ticketCost,
    this.howToReach,
    this.howToReachLunch,
    this.lunch,
    this.lunchReason,
    this.ticketCostLunch,
    this.lunchRating,
    this.lunchLink,
    this.timeLunch,
    this.ticketLinkLunch,
    this.activityNameLunch,
    this.reasonLunch,
    this.lunchCost,
    this.dinner,
    this.dinnerReason,
    this.dinnerRating,
    this.dinnerLink,
    this.dinnerCost,
    this.stay,
    this.stayLink,
    this.stayRating,
    this.stayCost,
    this.ratingLunch,
    this.imageUrl,
    this.foodImages,
    this.stayImage,
  });

  String? day;
  String? activityName;
  String? time;
  String? reason;
  String? ticketLink;
  String? ticketCost;
  String? howToReach;
  String? howToReachLunch;
  String? lunch;
  String? lunchReason;
  String? ticketCostLunch;
  String? lunchRating;
  String? lunchLink;
  String? timeLunch;
  String? ticketLinkLunch;
  String? activityNameLunch;
  String? reasonLunch;
  String? lunchCost;
  String? dinner;
  String? dinnerReason;
  String? dinnerRating;
  String? dinnerLink;
  String? dinnerCost;
  String? stay;
  String? stayLink;
  String? stayRating;
  String? stayCost;
  String? ratingLunch;
  List<Photo>? imageUrl;
  List<Photo>? foodImages;
  List<Photo>? stayImage;

  /// Factory method to create an instance from JSON
  factory ItineraryResultModel.fromJson(Map<String, dynamic> json) {
    return ItineraryResultModel(
      day: json['day'] as String?,
      activityName: json['activityName'] as String?,
      time: json['time'] as String?,
      reason: json['reason'] as String?,
      ticketLink: json['ticketLink'] as String?,
      ticketCost: json['ticketCost'] as String?,
      howToReach: json['howToReach'] as String?,
      howToReachLunch: json['howToReachLunch'] as String?,
      lunch: json['lunch'] as String?,
      lunchReason: json['lunchReason'] as String?,
      ticketCostLunch: json['ticketCostLunch'] as String?,
      lunchRating: json['lunchRating'] as String?,
      lunchLink: json['lunchLink'] as String?,
      timeLunch: json['timeLunch'] as String?,
      ticketLinkLunch: json['ticketLinkLunch'] as String?,
      activityNameLunch: json['activityNameLunch'] as String?,
      reasonLunch: json['reasonLunch'] as String?,
      lunchCost: json['lunchCost'] as String?,
      dinner: json['dinner'] as String?,
      dinnerReason: json['dinnerReason'] as String?,
      dinnerRating: json['dinnerRating'] as String?,
      dinnerLink: json['dinnerLink'] as String?,
      dinnerCost: json['dinnerCost'] as String?,
      stay: json['stay'] as String?,
      stayLink: json['stayLink'] as String?,
      stayRating: json['stayRating'] as String?,
      stayCost: json['stayCost'] as String?,
      ratingLunch: json['ratingLunch'] as String?,
      imageUrl: (json['imageUrl'] as List<dynamic>?)
          ?.map((item) => Photo.fromJson(item as Map<String, dynamic>))
          .toList(),
      foodImages: (json['foodImages'] as List<dynamic>?)
          ?.map((item) => Photo.fromJson(item as Map<String, dynamic>))
          .toList(),
      stayImage: (json['stayImage'] as List<dynamic>?)
          ?.map((item) => Photo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'activityName': activityName,
      'time': time,
      'reason': reason,
      'ticketLink': ticketLink,
      'ticketCost': ticketCost,
      'howToReach': howToReach,
      'howToReachLunch': howToReachLunch,
      'lunch': lunch,
      'lunchReason': lunchReason,
      'ticketCostLunch': ticketCostLunch,
      'lunchRating': lunchRating,
      'lunchLink': lunchLink,
      'timeLunch': timeLunch,
      'ticketLinkLunch': ticketLinkLunch,
      'activityNameLunch': activityNameLunch,
      'reasonLunch': reasonLunch,
      'lunchCost': lunchCost,
      'dinner': dinner,
      'dinnerReason': dinnerReason,
      'dinnerRating': dinnerRating,
      'dinnerLink': dinnerLink,
      'dinnerCost': dinnerCost,
      'stay': stay,
      'stayLink': stayLink,
      'stayRating': stayRating,
      'stayCost': stayCost,
      'ratingLunch': ratingLunch,
      'imageUrl': imageUrl?.map((item) => item.toJson()).toList(),
      'foodImages': foodImages?.map((item) => item.toJson()).toList(),
      'stayImage': stayImage?.map((item) => item.toJson()).toList(),
    };
  }

  /// Copy the current instance with modifications
  ItineraryResultModel copyWith({
    String? day,
    String? activityName,
    String? time,
    String? reason,
    String? ticketLink,
    String? ticketCost,
    String? howToReach,
    String? howToReachLunch,
    String? lunch,
    String? lunchReason,
    String? ticketCostLunch,
    String? lunchRating,
    String? lunchLink,
    String? timeLunch,
    String? ticketLinkLunch,
    String? activityNameLunch,
    String? reasonLunch,
    String? lunchCost,
    String? dinner,
    String? dinnerReason,
    String? dinnerRating,
    String? dinnerLink,
    String? dinnerCost,
    String? stay,
    String? stayLink,
    String? stayRating,
    String? stayCost,
    String? ratingLunch,
    List<Photo>? imageUrl,
    List<Photo>? foodImages,
    List<Photo>? stayImage,
  }) {
    return ItineraryResultModel(
      day: day ?? this.day,
      activityName: activityName ?? this.activityName,
      time: time ?? this.time,
      reason: reason ?? this.reason,
      ticketLink: ticketLink ?? this.ticketLink,
      ticketCost: ticketCost ?? this.ticketCost,
      howToReach: howToReach ?? this.howToReach,
      howToReachLunch: howToReachLunch ?? this.howToReachLunch,
      lunch: lunch ?? this.lunch,
      lunchReason: lunchReason ?? this.lunchReason,
      ticketCostLunch: ticketCostLunch ?? this.ticketCostLunch,
      lunchRating: lunchRating ?? this.lunchRating,
      lunchLink: lunchLink ?? this.lunchLink,
      timeLunch: timeLunch ?? this.timeLunch,
      ticketLinkLunch: ticketLinkLunch ?? this.ticketLinkLunch,
      activityNameLunch: activityNameLunch ?? this.activityNameLunch,
      reasonLunch: reasonLunch ?? this.reasonLunch,
      lunchCost: lunchCost ?? this.lunchCost,
      dinner: dinner ?? this.dinner,
      dinnerReason: dinnerReason ?? this.dinnerReason,
      dinnerRating: dinnerRating ?? this.dinnerRating,
      dinnerLink: dinnerLink ?? this.dinnerLink,
      dinnerCost: dinnerCost ?? this.dinnerCost,
      stay: stay ?? this.stay,
      stayLink: stayLink ?? this.stayLink,
      stayRating: stayRating ?? this.stayRating,
      stayCost: stayCost ?? this.stayCost,
      ratingLunch: ratingLunch ?? this.ratingLunch,
      imageUrl: imageUrl ?? this.imageUrl,
      foodImages: foodImages ?? this.foodImages,
      stayImage: stayImage ?? this.stayImage,
    );
  }
}
