import 'adDTO.dart';
import 'media-item.dart';

class GetAdDTO {
  final int id;
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
  final String governorateName;
  final String cityName;
  final String latitude;
  final String longitude;
  final String fullAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AdType adType;
  final String preferredContactMethod;
  final List<MediaItem> imageUrls;
  final AdCondition condition;
  final Map<String, dynamic> attributes;
  final Currency currency;

  GetAdDTO({
    required this.id,
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
    required this.governorateName,
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.adType,
    required this.preferredContactMethod,
    required this.imageUrls,
    required this.condition,
    required this.attributes,
    required this.currency,
  });

  factory GetAdDTO.fromJson(Map<String, dynamic> json) {
    return GetAdDTO(
      id: json['id'],
      title: json['title'],
      categoryPath: json['categoryPath'],
      categoryNamePath: json['categoryNamePath'],
      adNo: json['adNo'],
      description: json['description'],
      longDescription: json['longDescription'],
      tradePossible: json['tradePossible'],
      negotiable: json['negotiable'],
      contactPhone: json['contactPhone'],
      contactEmail: json['contactEmail'],
      userId: json['userId'],
      price: (json['price'] as num).toDouble(),
      governorateName: json['governorateName'],
      cityName: json['cityName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      fullAddress: json['fullAddress'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      adType: AdType.values.firstWhere(
        (e) => e.name == json['adType'],
        orElse: () => AdType.UNKNOWN,
      ),
      preferredContactMethod: json['preferredContactMethod'],
      imageUrls: (json['imageUrls'] as List<dynamic>)
          .map((e) => MediaItem.fromJson(e))
          .toList(),
      condition: AdCondition.values.firstWhere(
        (e) => e.name == json['condition'],
        orElse: () => AdCondition.DRAFT,
      ),
      attributes: json['attributes'] ?? {},
      currency: Currency.values.firstWhere(
        (e) => e.name == json['currency'],
        orElse: () => Currency.USD,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryPath': categoryPath,
      'categoryNamePath': categoryNamePath,
      'adNo': adNo,
      'description': description,
      'longDescription': longDescription,
      'tradePossible': tradePossible,
      'negotiable': negotiable,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'userId': userId,
      'price': price,
      'governorateName': governorateName,
      'cityName': cityName,
      'latitude': latitude,
      'longitude': longitude,
      'fullAddress': fullAddress,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'adType': adType.name,
      'preferredContactMethod': preferredContactMethod,
      'imageUrls': imageUrls.map((e) => e.toJson()).toList(),
      'condition': condition.name,
      'attributes': attributes,
      'currency': currency.name,
    };
  }
}

enum AdCondition {
  PUBLISHED,
  PENDING,
  REJECTED,
  ARCHIVED,
  SUSPENDED,
  DELETED,
  EXPIRED,
  DRAFT,
}
