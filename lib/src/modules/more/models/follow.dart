class FollowProfileModel {
  final int? id;
  final String? username;
  final String? email;
  final String? birthday;
  final String? verificationToken;
  final String? oauth2Provider;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profilePicture;
  final bool? isVerified;
  final String? businessName;
  final String? businessLicense;
  final String? createdAt;
  final String? updatedAt;
  final String? lastLogin;
  final bool? active;
  final String? status;
  final bool? isFollowing;
  final Links? links;

  FollowProfileModel({
    this.id,
    this.username,
    this.email,
    this.birthday,
    this.verificationToken,
    this.oauth2Provider,
    this.password,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profilePicture,
    this.isVerified,
    this.businessName,
    this.businessLicense,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.active,
    this.status,
    this.isFollowing,
    this.links,
  });

  factory FollowProfileModel.fromJson(Map<String, dynamic> json) {
    return FollowProfileModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      birthday: json['birthday'],
      verificationToken: json['verificationToken'],
      oauth2Provider: json['oauth2Provider'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      isVerified: json['isVerified'],
      businessName: json['businessName'],
      businessLicense: json['businessLicense'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      lastLogin: json['lastLogin'],
      active: json['active'],
      status: json['status'],
      isFollowing: json['isFollowing'],
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'birthday': birthday,
      'verificationToken': verificationToken,
      'oauth2Provider': oauth2Provider,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'isVerified': isVerified,
      'businessName': businessName,
      'businessLicense': businessLicense,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastLogin': lastLogin,
      'active': active,
      'status': status,
      'isFollowing': isFollowing,
      '_links': links?.toJson(),
    };
  }
}

class Links {
  final Link self;
  final Link user;
  final Link following;
  final Link followers;
  final Link roles;

  Links({
    required this.self,
    required this.user,
    required this.following,
    required this.followers,
    required this.roles,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: Link.fromJson(json['self']),
      user: Link.fromJson(json['user']),
      following: Link.fromJson(json['following']),
      followers: Link.fromJson(json['followers']),
      roles: Link.fromJson(json['roles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'self': self.toJson(),
      'user': user.toJson(),
      'following': following.toJson(),
      'followers': followers.toJson(),
      'roles': roles.toJson(),
    };
  }
}

class Link {
  final String href;

  Link({required this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'href': href};
  }
}
