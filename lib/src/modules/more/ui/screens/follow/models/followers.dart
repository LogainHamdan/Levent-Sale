class Address {
  final int id;
  final String governorate, city, fullAddress;

  Address(
      {required this.id,
      required this.governorate,
      required this.city,
      required this.fullAddress});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        governorate: json['governorate'],
        city: json['city'],
        fullAddress: json['fullAddress'],
      );
}

class FollowerModel {
  final String username, firstName, lastName, email, phoneNumber;
  final String profilePicture, businessName, businessLicense;
  final String birthday;
  final Address address;
  final int followersCount, followingCount;

  FollowerModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.businessName,
    required this.businessLicense,
    required this.birthday,
    required this.address,
    required this.followersCount,
    required this.followingCount,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        username: json['username'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        profilePicture: json['profilePicture'],
        businessName: json['businessName'],
        businessLicense: json['businessLicense'],
        birthday: json['birthday'],
        address: Address.fromJson(json['address']),
        followersCount: json['followersCount'],
        followingCount: json['followingCount'],
      );
}
