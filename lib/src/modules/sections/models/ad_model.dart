import '../../more/models/profile.dart';
import 'package:html_unescape/html_unescape.dart';

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
  final Map<String, dynamic>? attributes;
  final int? viewCount;
  final Profile? userProfile;
  final String? tagId;
  final String? categoryPath;
  final String? categoryNamePath;

  AdModel({
    this.id,
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
    this.categoryPath,
  });

  String get cleanDescription {
    final unescape = HtmlUnescape();
    final rawHtml = description ?? '';
    final noTags = rawHtml.replaceAll(RegExp(r'<[^>]*>'), '');
    return unescape.convert(noTags);
  }

  String get cleanLongDescription {
    final unescape = HtmlUnescape();
    final rawHtml = longDescription ?? '';
    final noTags = rawHtml.replaceAll(RegExp(r'<[^>]*>'), '');
    return unescape.convert(noTags);
  }

  factory AdModel.fromJson(Map<String, dynamic> json) {
    try {
      return AdModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        title: json['title'],
        adNo: json['adNo'],
        categoryNamePath: json['categoryNamePath'],
        categoryPath: json['categoryPath'],
        description: json['description'],
        longDescription: json['longDescription'],
        tradePossible: json['tradePossible'] == true || json['tradePossible'] == 'نعم',
        negotiable: json['negotiable'] == true || json['negotiable'] == 'نعم',
        contactPhone: json['contactPhone'],
        contactEmail: json['contactEmail'],
        userId: json['userId'],
        price: json['price'] != null
            ? double.tryParse(json['price'].toString())?.toInt()
            : null,

        // إصلاح governorate ليتعامل مع String أو Object
        governorate: (() {
          final gov = json['governorate'];
          if (gov == null) return null;
          if (gov is String) {
            return Governorate(governorateName: gov);
          } else if (gov is Map<String, dynamic>) {
            return Governorate.fromJson(gov);
          } else {
            return Governorate(governorateName: json['governorateName']);
          }
        })(),

        // إصلاح city ليتعامل مع String أو Object
        city: (() {
          final cityData = json['city'];
          if (cityData == null) return null;
          if (cityData is String) {
            return City(cityName: cityData);
          } else if (cityData is Map<String, dynamic>) {
            return City.fromJson(cityData);
          } else {
            return City(cityName: json['cityName']);
          }
        })(),

        fullAddress: json['fullAddress'],
        address: json.containsKey('address') && json['address'] != null
            ? Address.fromJson(json['address'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'].toString())
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'].toString())
            : null,
        adType: json['adType'],
        preferredContactMethod: json['preferredContactMethod'],

        // إصلاح condition ليتعامل مع أنواع مختلفة
        condition: (() {
          final cond = json['condition'];
          if (cond == null) return null;
          if (cond is List) {
            return cond.map((e) => e?.toString()).toList();
          } else {
            return [cond.toString()];
          }
        })(),

        currency: json['currency'],

        // إصلاح imageUrls ليتعامل مع الـ API response الحالي
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

        attributes: json['attributes'] is Map<String, dynamic>
            ? json['attributes']
            : null,
        viewCount: json['viewCount'] != null
            ? int.tryParse(json['viewCount'].toString())
            : null,
        userProfile: json['userProfile'] != null
            ? Profile.fromJson(json['userProfile'])
            : null,
        tagId: json['tagId']?.toString(),
      );
    } catch (e) {
      print('Error in AdModel.fromJson: $e');
      print('JSON data: $json');
      rethrow;
    }
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