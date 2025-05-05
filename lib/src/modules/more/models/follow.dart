class FollowProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String profilePicture;

  FollowProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  factory FollowProfileModel.fromJson(Map<String, dynamic> json) {
    return FollowProfileModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
    };
  }
}
