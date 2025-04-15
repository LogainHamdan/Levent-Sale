class PersonalModel {
  final dynamic username;
  final dynamic email;
  final dynamic password;
  final dynamic phoneNumber;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic profilePicture;
  final bool isVerified;
  final dynamic birthday;
  final bool active;
  final dynamic status;
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
        "birthday": birthday,
        "active": active,
        "status": status,
        "roles": roles,
      };
  factory PersonalModel.fromJson(Map<dynamic, dynamic> json) {
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
