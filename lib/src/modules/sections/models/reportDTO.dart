class ReportDTO {
  final int reportToId;
  final String? reportType;
  final String reason;
  final String? description;

  ReportDTO({
    required this.reportToId,
    this.reportType,
    required this.reason,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'reportToId': reportToId,
      'reportType': reportType,
      'reason': reason,
      'description': description,
    };
  }
}

enum ReportType { user, ad }

extension ReportTypeExtension on ReportType {
  String get name {
    switch (this) {
      case ReportType.user:
        return 'User';
      case ReportType.ad:
        return 'Ad';
    }
  }

  static ReportType fromString(String value) {
    switch (value) {
      case 'User':
        return ReportType.user;
      case 'Ad':
        return ReportType.ad;
      default:
        throw Exception('Unknown ReportType: $value');
    }
  }

  String get arabicName {
    switch (this) {
      case ReportType.user:
        return 'إبلاغ عن مستخدم';
      case ReportType.ad:
        return 'إبلاغ عن إعلان';

    }
  }
}
