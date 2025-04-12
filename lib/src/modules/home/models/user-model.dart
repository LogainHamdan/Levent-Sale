class UserModel {
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
  final Address? address;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;

  UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.birthday = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.businessName = '',
    this.businessLicense = '',
    this.address,
    this.followersCount = 0,
    this.followingCount = 0,
    this.isFollowing = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      birthday: json['birthday'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      businessName: json['businessName'] ?? '',
      businessLicense: json['businessLicense'] ?? '',
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      isFollowing: json['following'] ?? json['isFollowing'] ?? false,
    );
  }
}

class Address {
  final int id;
  final String governorate;
  final String city;
  final String fullAddress;

  Address({
    required this.id,
    required this.governorate,
    required this.city,
    required this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      governorate: json['governorate'],
      city: json['city'],
      fullAddress: json['fullAddress'],
    );
  }
}
