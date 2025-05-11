import '../../more/models/profile.dart';
import 'media-item.dart';

class AdModel {
  final int? id;
  final String? title;
  final String? categoryPath;
  final String? categoryNamePath;
  final String? adNo;
  final String? description;
  final String? longDescription;
  final bool? tradePossible;
  final bool? negotiable;
  final String? contactPhone;
  final String? contactEmail;
  final int? userId;
  final int? price;
  final Governorate? governorate;
  final City? city;
  final String? fullAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? adType;
  final String? preferredContactMethod;
  final List<String>? condition;
  final String? currency;
  final List<MediaItem>? imageUrls;
  final Map<String?, dynamic>? attributes;

  AdModel({
    this.id,
    this.title,
    this.categoryPath,
    this.categoryNamePath,
    this.adNo,
    this.description,
    this.longDescription,
    this.tradePossible,
    this.negotiable,
    this.contactPhone,
    this.contactEmail,
    this.userId,
    this.price,
    this.governorate,
    this.city,
    this.fullAddress,
    this.createdAt,
    this.updatedAt,
    this.adType,
    this.preferredContactMethod,
    this.condition,
    this.currency,
    this.imageUrls,
    this.attributes,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      title: json['title'],
      categoryPath: json['categoryPath'],
      categoryNamePath: json['categoryNamePath'],
      adNo: json['adNo'],
      description: json['description'],
      longDescription: json['longDescription'],
      tradePossible:
          json['tradePossible'] == true || json['tradePossible'] == 'نعم',
      negotiable: json['negotiable'] == true || json['negotiable'] == 'نعم',
      contactPhone: json['contactPhone'],
      contactEmail: json['contactEmail'],
      userId: json['userId'],
      price:
          json['price'] != null ? int.tryParse(json['price'].toString()) : null,
      governorate: json['governorate'] != null
          ? Governorate.fromJson(json['governorate'])
          : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      fullAddress: json['fullAddress'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      adType: json['adType'],
      preferredContactMethod: json['preferredContactMethod'],
      condition:
          (json['condition'] as List?)?.map((e) => e.toString()).toList(),
      currency: json['currency'],
      imageUrls: json['imageUrls'] is List
          ? (json['imageUrls'] as List)
              .where((e) => e is Map<String, dynamic>)
              .map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      attributes: json['attributes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
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
      "governorate": governorate?.toJson(),
      "city": city?.toJson(),
      "fullAddress": fullAddress,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "adType": adType,
      "preferredContactMethod": preferredContactMethod,
      "condition": condition,
      "currency": currency,
      "imageUrls": imageUrls?.map((e) => e.toJson()).toList(),
      "attributes": attributes,
    };
  }
}
