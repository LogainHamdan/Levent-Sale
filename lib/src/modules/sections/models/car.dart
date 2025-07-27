class Car {
  final String drive;
  final double cylinders;
  final String fuelType1;
  final String vehicleSizeClass;
  final int cityMpqForFuelType1;

  Car({
    required this.drive,
    required this.cylinders,
    required this.fuelType1,
    required this.vehicleSizeClass,
    required this.cityMpqForFuelType1,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      drive: json['drive'] ?? '',
      cylinders: (json['cylinders'] ?? 0).toDouble(),
      fuelType1: json['fuelType1'] ?? '',
      vehicleSizeClass: json['vehicleSizeClass'] ?? '',
      cityMpqForFuelType1: (json['cityMpqForFuelType1'] ?? 0).toInt(),
    );
  }
}
