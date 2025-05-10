class Address {
  final int? id;
  final Governorate? governorate;
  final City? city;
  final String? fullAddress;

  Address({
    this.id,
    this.governorate,
    this.city,
    this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      governorate: json['governorate'] != null
          ? Governorate.fromJson(json['governorate'])
          : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      fullAddress: json['fullAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate': governorate?.toJson(),
      'city': city?.toJson(),
      'fullAddress': fullAddress,
    };
  }
}

class Governorate {
  final int? id;
  final String? name;

  Governorate({
    this.id,
    this.name,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class City {
  final int? id;
  final String? name;

  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
