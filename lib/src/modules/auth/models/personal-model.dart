class PersonalModel {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final bool isVerified;
  final String birthday;
  final bool active;
  final String status;
  final List<String> roles;

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

  Map<String, dynamic> toJson() => {
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
}
