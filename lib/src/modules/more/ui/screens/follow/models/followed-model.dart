class FollowedUserModel {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String birthday;
  final String phoneNumber;
  final String profilePicture;
  final String businessName;
  final String businessLicense;
  final Address address;
  final int followersCount;
  final int followingCount;
  bool isFollowing;

  FollowedUserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.phoneNumber,
    required this.profilePicture,
    required this.businessName,
    required this.businessLicense,
    required this.address,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
  });

  factory FollowedUserModel.fromJson(Map<String, dynamic> json) {
    return FollowedUserModel(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      birthday: json['birthday'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      businessName: json['businessName'],
      businessLicense: json['businessLicense'],
      address: Address.fromJson(json['address']),
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      isFollowing: json['isFollowing'] ?? true, // default true if not provided
    );
  }
}

class Address {
  final String governorate;
  final String city;
  final String neighborhood;
  final String street;
  final String buildingNo;

  Address({
    required this.governorate,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.buildingNo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      governorate: json['governorate'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
      buildingNo: json['buildingNo'],
    );
  }
}
