class GroupModel {
  GroupModel(
      {required this.id, required this.groupName, required this.groupMembers});

  final String id;
  final String groupName;
  final List<GroupMember> groupMembers;

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        id: json["_id"] ?? "",
        groupName: json["groupName"] ?? "",
        groupMembers: json["groupMembers"] == null
            ? []
            : List<GroupMember>.from(
                json["groupMembers"]!.map((x) => GroupMember.fromJson(x))));
  }
}

class GroupMember {
  GroupMember({
    required this.id,
    required this.pictureUrl,
    required this.fullName,
    required this.youOwedAmount,
    required this.youAreOwedAmount,
  });

  final String id;
  final String pictureUrl;
  final String fullName;
  final String youOwedAmount;
  final String youAreOwedAmount;

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
        id: json["id"] ?? "",
        fullName: json["fullName"] ?? "",
        pictureUrl: json["pictureUrl"] ??
            "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png",
        youOwedAmount: json["youOwedAmount"].toString(),
        youAreOwedAmount: json["youAreOwedAmount"].toString());
  }
}

class CreateGroupResponse {
  CreateGroupResponse({required this.id});

  final String id;

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponse(id: json["_id"] ?? "");
  }
}
