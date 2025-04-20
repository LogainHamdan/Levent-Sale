import 'package:intl/intl.dart';

import '../../home/models/address.dart';

class User {
  int? id;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? profilePicture;
  bool? isVerified;
  String? businessName;
  String? businessLicense;
  DateTime? birthday;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastLogin;
  String? verificationToken;
  bool? active;
  String? oauth2Provider;
  String? status;
  List<String>? roles;
  Address? address;
  int? followersCount;
  int? followingCount;
  bool? isFollowing;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.isVerified,
    this.businessName,
    this.businessLicense,
    this.birthday,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.verificationToken,
    this.active,
    this.oauth2Provider,
    this.status,
    this.roles,
    this.address,
    this.followersCount,
    this.followingCount,
    this.isFollowing,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthday: json['birthday'] != null
          ? DateFormat('dd-MM-yyyy').parse(json['birthday'])
          : null,
      profilePicture: json['profilePicture'],
      roles: List<String>.from(json['roles'] ?? []),
      businessName: json['businessName'],
      businessLicense: json['businessLicense'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'isVerified': isVerified,
      'businessName': businessName,
      'businessLicense': businessLicense,
      'birthday': birthday?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'verification_token': verificationToken,
      'active': active,
      'oauth2Provider': oauth2Provider,
      'status': status,
      'roles': roles,
      'address': address?.toJson(),
      'followersCount': followersCount,
      'followingCount': followingCount,
      'isFollowing': isFollowing,
    };
  }
}
