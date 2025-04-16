class AdAttributesModel {
  final int? id;
  final int? categoryId;
  final Attributes? attributes;
  final List<Detail>? details;

  AdAttributesModel({
    this.id,
    this.categoryId,
    this.attributes,
    this.details,
  });

  factory AdAttributesModel.fromJson(Map<String, dynamic> json) {
    return AdAttributesModel(
      id: json['id'],
      categoryId: json['categoryId'],
      attributes: Attributes.fromJson(json['attributes']),
      details:
          List<Detail>.from(json['details'].map((x) => Detail.fromJson(x))),
    );
  }
}

class Attributes {
  final List<Field>? fields;

  Attributes({this.fields});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      fields: List<Field>.from(json['fields'].map((x) => Field.fromJson(x))),
    );
  }
}

enum FieldType { dropdown, text, checkbox, number }

FieldType fieldTypeFromString(String type) {
  switch (type) {
    case 'dropdown':
      return FieldType.dropdown;
    case 'text':
      return FieldType.text;
    case 'checkbox':
      return FieldType.checkbox;
    case 'number':
      return FieldType.number;
    default:
      throw Exception('Unknown field type: $type');
  }
}

String fieldTypeToString(FieldType type) {
  return type.name;
}

class Field {
  final String? name;
  final FieldType? type;
  final String? label;
  final List<String>? options;
  final bool? required;
  final dynamic defaultValue;
  final Validation? validation;
  final String? placeholder;

  Field({
    this.name,
    this.type,
    this.label,
    this.options,
    this.required,
    this.defaultValue,
    this.validation,
    this.placeholder,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      name: json['name'],
      type: fieldTypeFromString(json['type']),
      label: json['label'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      required: json['required'],
      defaultValue: json['defaultValue'],
      validation: json['validation'] != null
          ? Validation.fromJson(json['validation'])
          : null,
      placeholder: json['placeholder'],
    );
  }
}

class Validation {
  final int? max;
  final int? min;
  final String? pattern;

  Validation({this.max, this.min, this.pattern});

  factory Validation.fromJson(Map<String, dynamic> json) {
    return Validation(
      max: json['max'],
      min: json['min'],
      pattern: json['pattern'],
    );
  }
}

class Detail {
  final int? id;
  final String? name;

  Detail({this.id, this.name});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      name: json['name'],
    );
  }
}
