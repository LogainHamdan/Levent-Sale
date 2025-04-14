class AdModel {
  final String title;
  final String categoryPath;
  final String categoryNamePath;
  final String adNo;
  final String description;
  final String longDescription;
  final bool tradePossible;
  final bool negotiable;
  final String contactPhone;
  final String contactEmail;
  final int userId;
  final double price;
  final String governorate;
  final String city;
  final String fullAddress;
  final String adType;
  final String preferredContactMethod;
  final String condition;
  final String currency;
  final Map<String, dynamic> attributes;

  AdModel({
    required this.title,
    required this.categoryPath,
    required this.categoryNamePath,
    required this.adNo,
    required this.description,
    required this.longDescription,
    required this.tradePossible,
    required this.negotiable,
    required this.contactPhone,
    required this.contactEmail,
    required this.userId,
    required this.price,
    required this.governorate,
    required this.city,
    required this.fullAddress,
    required this.adType,
    required this.preferredContactMethod,
    required this.condition,
    required this.currency,
    required this.attributes,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "categoryPath": categoryPath,
      "categoryNamePath": categoryNamePath,
      "adNo": adNo,
      "description": description,
      "longDescription": longDescription,
      "tradePossible": tradePossible,
      "negotiable": negotiable,
      "contactPhone": contactPhone,
      "contactEmail": contactEmail,
      "userId": userId,
      "price": price,
      "governorate": governorate,
      "city": city,
      "fullAddress": fullAddress,
      "adType": adType,
      "preferredContactMethod": preferredContactMethod,
      "condition": condition,
      "currency": currency,
      "attributes": attributes,
    };
  }
}
