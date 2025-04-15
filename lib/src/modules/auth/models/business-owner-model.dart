class BusinessOwner {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final bool isVerified;
  final String businessName;
  final String businessLicense;
  final String birthday;
  final String? verificationToken;
  final bool active;
  final String? oauth2Provider;
  final String status;
  final List<String> roles;

  BusinessOwner({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    required this.isVerified,
    required this.businessName,
    required this.businessLicense,
    required this.birthday,
    this.verificationToken,
    required this.active,
    this.oauth2Provider,
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
        "businessName": businessName,
        "businessLicense": businessLicense,
        "birthday": birthday,
        "verification_token": verificationToken,
        "active": active,
        "oauth2Provider": oauth2Provider,
        "status": status,
        "roles": roles,
      };
}
