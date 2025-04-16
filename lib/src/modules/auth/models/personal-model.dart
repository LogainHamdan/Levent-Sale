import 'package:intl/intl.dart';

class PersonalModel {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final dynamic profilePicture;
  final bool isVerified;
  final String? birthday;
  final bool active;
  final String status;
  final List<dynamic> roles;

  PersonalModel({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.isVerified,
    required this.birthday,
    required this.active,
    required this.status,
    required this.roles,
  });

  Map<dynamic, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "isVerified": isVerified,
        "birthday": birthday != null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                .format(DateTime.parse(birthday!))
            : null, // تأكيد تنسيق الـ birthday
        "createdAt": DateFormat("yyyy-MM-dd'T'HH:mm:ss")
            .format(DateTime.now()), // تاريخ الإنشاء
        "updatedAt": DateFormat("yyyy-MM-dd'T'HH:mm:ss")
            .format(DateTime.now()), // تاريخ التحديث
        "lastLogin": DateFormat("yyyy-MM-dd'T'HH:mm:ss")
            .format(DateTime.now()), // تاريخ آخر تسجيل دخول
        "verification_token": '',
        "active": active,
        "oauth2Provider": '',
        "status": status,
        "roles": roles,
      };

  factory PersonalModel.fromJson(Map<String, dynamic> json) {
    return PersonalModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      isVerified: json['isVerified'],
      birthday: json['birthday'],
      active: json['active'],
      status: json['status'],
      roles: List<dynamic>.from(json['roles']),
    );
  }
}
