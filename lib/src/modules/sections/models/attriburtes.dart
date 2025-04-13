class AdAttributesModel {
  final int id;
  final int categoryId;
  final Attributes attributes;
  final List<Detail> details;

  AdAttributesModel({
    required this.id,
    required this.categoryId,
    required this.attributes,
    required this.details,
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
  final List<Field> fields;

  Attributes({required this.fields});

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
  final String name;
  final FieldType type;
  final String label;
  final List<String>? options;
  final bool required;
  final dynamic defaultValue;
  final Validation? validation;
  final String? placeholder;

  Field({
    required this.name,
    required this.type,
    required this.label,
    this.options,
    required this.required,
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
  final int id;
  final String name;

  Detail({required this.id, required this.name});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      name: json['name'],
    );
  }
}
