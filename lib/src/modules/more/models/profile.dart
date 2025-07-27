class Profile {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? birthday;
  final String? phoneNumber;
  final String? profilePicture;
  final String? businessName;
  final String? businessLicense;
  final Address? address;
  final int? followersCount;
  final int? followingCount;
  final bool? following;

  Profile({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.birthday,
    this.phoneNumber,
    this.profilePicture,
    this.businessName,
    this.businessLicense,
    this.address,
    this.followersCount,
    this.followingCount,
    this.following,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      birthday: json['birthday'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      businessName: json['businessName'],
      businessLicense: json['businessLicense'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      following: json['following'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'businessName': businessName,
      'businessLicense': businessLicense,
      'address': address?.toJson(),
      'followersCount': followersCount,
      'followingCount': followingCount,
      'following': following,
    };
  }
}

class Address {
  final int? id;
  final Governorate? governorate;
  final City? city;
  final String? fullAddresse;

  Address({
    this.id,
    this.governorate,
    this.city,
    this.fullAddresse,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      governorate: json['governorate'] != null
          ? Governorate.fromJson(json['governorate'])
          : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      fullAddresse: json['fullAddresse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate': governorate?.toJson(),
      'city': city?.toJson(),
      'fullAddresse': fullAddresse,
    };
  }
}

class Governorate {
  final int? id;
  final String? governorateName;

  Governorate({
    this.id,
    this.governorateName,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'] ?? 0,
      governorateName: json['governorateName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class City {
  final int? id;
  final String? cityName;
  final String? latitude;
  final String? longitude;
  final int? sort;

  City({
    this.id,
    this.cityName,
    this.latitude,
    this.longitude,
    this.sort,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      cityName: json['cityName'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      sort: json['sort'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
