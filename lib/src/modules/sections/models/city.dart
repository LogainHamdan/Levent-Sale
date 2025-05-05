class City {
  final String? cityName;
  final String? latitude;
  final String? longitude;
  final int? sort;

  City({
    this.cityName,
    this.latitude,
    this.longitude,
    this.sort,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityName: json['cityName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      sort: json['sort'],
    );
  }
}

class Governorate {
  final String? governorateName;

  Governorate({required this.governorateName});

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      governorateName: json['governorateName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governorateName': governorateName,
    };
  }
}
