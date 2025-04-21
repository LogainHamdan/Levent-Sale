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
  final double? price;
  final String? governorate;
  final String? city;
  final String? fullAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? adType;
  final String? preferredContactMethod;
  final String? condition;
  final String? currency;
  final List<String>? imageUrls;
  final Map<String, dynamic>? attributes;
  final String? tagId;

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
    this.tagId,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "categoryPath": categoryPath,
      "categoryNamePath": categoryNamePath,
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
      "tagId": tagId,
    };
  }

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
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      governorate: json['governorate'],
      city: json['city'],
      fullAddress: json['fullAddress'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      adType: json['adType'],
      preferredContactMethod: json['preferredContactMethod'],
      condition: json['condition'],
      currency: json['currency'],
      imageUrls:
          (json['imageUrls'] as List?)?.map((e) => e.toString()).toList(),
      attributes: json['attributes'],
      tagId: json['tagId'],
    );
  }
}
