class Address {
  final int id;
  final String governorate;
  final String city;
  final String fullAddress;

  Address({
    required this.id,
    required this.governorate,
    required this.city,
    required this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      governorate: json['governorate'],
      city: json['city'],
      fullAddress: json['fullAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate': governorate,
      'city': city,
      'fullAddress': fullAddress,
    };
  }
}
