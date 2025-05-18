import '../../more/models/profile.dart';
import 'attriburtes.dart';

class AdDTO {
  final City? city;
  final Governorate? governorate;
  final String? adType;
  final String? contactEmail;
  final String? contactPhone;
  final Currency? currency;
  final String? description;
  final String? longDescription;
  final String? fullAddress;
  final bool? negotiable;
  final String? preferredContactMethod;
  final String? price;
  final String? title;
  final bool? tradePossible;
  final String? categoryPath;
  final Map<String, dynamic>? attributes;

  AdDTO({
    this.city,
    this.governorate,
    this.adType,
    this.contactEmail,
    this.contactPhone,
    this.currency,
    this.description,
    this.longDescription,
    this.fullAddress,
    this.negotiable,
    this.preferredContactMethod,
    this.price,
    this.title,
    this.tradePossible,
    this.categoryPath,
    this.attributes,
  });

  factory AdDTO.fromJson(Map<String, dynamic> json) => AdDTO(
        city: City.fromJson(json['city']),
        governorate: Governorate.fromJson(json['governorate']),
        adType: json['adType'],
        contactEmail: json['contactEmail'],
        contactPhone: json['contactPhone'],
        currency: json['currency'],
        description: json['description'],
        longDescription: json['longDescription'],
        fullAddress: json['fullAddress'],
        negotiable: json['negotiable'],
        preferredContactMethod: json['preferredContactMethod'],
        price: json['price'],
        title: json['title'],
        tradePossible: json['tradePossible'],
        categoryPath: json['categoryPath'],
        attributes: json['attributes'],
      );

  Map<String, dynamic> toJson() => {
        'city': city?.toJson(),
        'governorate': governorate?.toJson(),
        'adType': adType,
        'contactEmail': contactEmail,
        'contactPhone': contactPhone,
        'currency': currency,
        'description': description,
        'longDescription': longDescription,
        'fullAddress': fullAddress,
        'negotiable': negotiable,
        'preferredContactMethod': preferredContactMethod,
        'price': price,
        'title': title,
        'tradePossible': tradePossible,
        'categoryPath': categoryPath,
        "attributes": attributes,
      };
}

enum Currency { SYP, TRY, USD }

extension CurrencyExtension on Currency {
  String get arabicName {
    switch (this) {
      case Currency.SYP:
        return 'ليرة سورية';
      case Currency.TRY:
        return 'ليرة تركية';
      case Currency.USD:
        return 'دولار أمريكي';
      default:
        return '';
    }
  }

  static Currency? fromArabicName(String arabicName) {
    switch (arabicName) {
      case 'ليرة سورية':
        return Currency.SYP;
      case 'ليرة تركية':
        return Currency.TRY;
      case 'دولار أمريكي':
        return Currency.USD;
      default:
        return null;
    }
  }
}

enum ContactMethod {
  CALL,
  WHATSAPP,
  SMS,
  EMAIL,
  SITE_MESSAGES,
  TELEGRAM,
  OTHER,
}

extension ContactMethodExtension on ContactMethod {
  String get displayName {
    switch (this) {
      case ContactMethod.CALL:
        return 'اتصال';
      case ContactMethod.WHATSAPP:
        return 'واتساب';
      case ContactMethod.SMS:
        return 'رسالة نصية';
      case ContactMethod.EMAIL:
        return 'بريد';
      case ContactMethod.SITE_MESSAGES:
        return 'رسائل الموقع';
      case ContactMethod.TELEGRAM:
        return 'تيليجرام';
      case ContactMethod.OTHER:
        return 'أخرى';
    }
  }

  static ContactMethod fromDisplayName(String displayName) {
    return ContactMethod.values.firstWhere((e) => e.displayName == displayName,
        orElse: () => ContactMethod.OTHER);
  }
}

enum AdType {
  NEW,
  USED,
  EXCELLENT,
  GOOD,
  REFURBISHED,
  NEEDS_REPAIR,
  PARTS,
  UNKNOWN,
}

extension AdTypeExtension on AdType {
  String get displayName {
    switch (this) {
      case AdType.NEW:
        return 'جديد';
      case AdType.USED:
        return 'مستعمل';
      case AdType.EXCELLENT:
        return 'ممتاز';
      case AdType.GOOD:
        return 'جيد';
      case AdType.REFURBISHED:
        return 'مجدّد';
      case AdType.NEEDS_REPAIR:
        return 'يحتاج إلى إصلاح';
      case AdType.PARTS:
        return 'قطع غيار';
      case AdType.UNKNOWN:
        return 'غير معروف';
    }
  }

  static AdType fromDisplayName(String displayName) {
    return AdType.values.firstWhere(
      (e) => e.displayName == displayName,
      orElse: () => AdType.UNKNOWN,
    );
  }
}
