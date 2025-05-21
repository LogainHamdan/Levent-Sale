import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import '../../more/models/profile.dart';

class AdModel {
  final int? id;
  final String? title;
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
  final Address? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? adType;
  final String? preferredContactMethod;
  final List<String?>? condition;
  final String? currency;
  final List<String>? imageUrls;
  final Map<String?, dynamic>? attributes;
  final int? viewCount;
  final Profile? userProfile;
  final String? tagId;
  final String? categoryPath;
  final String? categoryNamePath;

  AdModel(
      {this.id,
      this.title,
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
      this.address,
      this.createdAt,
      this.updatedAt,
      this.adType,
      this.preferredContactMethod,
      this.condition,
      this.currency,
      this.imageUrls,
      this.attributes,
      this.viewCount,
      this.userProfile,
      this.tagId,
      this.categoryNamePath,
      this.categoryPath});

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      title: json['title'],
      adNo: json['adNo'],
      categoryNamePath: json['categoryNamePath'],
      categoryPath: json['categoryPath'],
      description: json['description'],
      longDescription: json['longDescription'],
      tradePossible:
          json['tradePossible'] == true || json['tradePossible'] == 'نعم',
      negotiable: json['negotiable'] == true || json['negotiable'] == 'نعم',
      contactPhone: json['contactPhone'],
      contactEmail: json['contactEmail'],
      userId: json['userId'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())?.toInt()
          : null,
      governorate: json.containsKey('governorate')
          ? Governorate.fromJson(json['governorate'])
          : Governorate(governorateName: json['governorateName']),
      city: json.containsKey('city')
          ? City.fromJson(json['city'])
          : City(cityName: json['cityName']),
      fullAddress: json['fullAddress'],
      address: json.containsKey('address')
          ? Address.fromJson(json['address'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      adType: json['adType'],
      preferredContactMethod: json['preferredContactMethod'],
      condition: json['condition'] is List
          ? (json['condition'] as List).map((e) => e.toString()).toList()
          : [json['condition']],
      currency: json['currency'],
      imageUrls: (() {
        final raw = json['imageUrls'];
        if (raw == null) return null;

        if (raw is String) {
          return [raw];
        } else if (raw is List) {
          return raw.map((e) {
            if (e is Map && e.containsKey('url')) {
              return e['url'].toString();
            } else {
              return e.toString();
            }
          }).toList();
        } else {
          return null;
        }
      })(),
      attributes: json['attributes'] is Map ? json['attributes'] : null,
      userProfile: json['userProfile'] != null
          ? Profile.fromJson(json['userProfile'])
          : null,
      tagId: json['tagId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'adNo': adNo,
      'description': description,
      'longDescription': longDescription,
      'tradePossible': tradePossible,
      'negotiable': negotiable,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'userId': userId,
      'price': price,
      'governorate': governorate?.toJson(),
      'city': city?.toJson(),
      'fullAddress': fullAddress,
      'address': address?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'adType': adType,
      'preferredContactMethod': preferredContactMethod,
      'condition': condition,
      'currency': currency,
      'imageUrls': imageUrls?.map((e) => {'url': e}).toList(),
      'attributes': attributes,
      'viewCount': viewCount,
      'userProfile': userProfile?.toJson(),
      'tagId': tagId,
      'categoryNamePath': categoryNamePath,
      'categoryPath': categoryPath,
    };
  }
}
