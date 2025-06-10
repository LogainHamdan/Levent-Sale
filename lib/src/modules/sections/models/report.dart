class Report {
  final String? id;
  final int? reportToId;
  final int? reporterId;
  final String? reason;
  final String? description;
  final DateTime? reportedAt;
  final String? reportType;
  final String? status;

  Report({
    this.id,
    this.reportToId,
    this.reporterId,
    this.reason,
    this.description,
    this.reportedAt,
    this.reportType,
    this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    final List<dynamic> reportedAtArray = json['reportedAt'];

    return Report(
      id: json['id'],
      reportToId: json['reportToId'],
      reporterId: json['reporterId'],
      reason: json['reason'],
      description: json['description'],
      reportedAt: DateTime(
        reportedAtArray[0],
        reportedAtArray[1],
        reportedAtArray[2],
        reportedAtArray[3],
        reportedAtArray[4],
        reportedAtArray[5],
        reportedAtArray[6] ~/ 1000000,
      ),
      reportType: json['reportType'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reportToId': reportToId,
      'reporterId': reporterId,
      'reason': reason,
      'description': description,
      'reportedAt': reportedAt?.toIso8601String(),
      'reportType': reportType,
      'status': status,
    };
  }
}

enum ReportStatus {
  newReport,
  pending,
  underReview,
  needsMoreInfo,
  resolved,
  rejected,
  closed,
  archived
}

extension ReportStatusExtension on ReportStatus {
  String get name {
    switch (this) {
      case ReportStatus.newReport:
        return 'NEW';
      case ReportStatus.pending:
        return 'PENDING';
      case ReportStatus.underReview:
        return 'UNDER_REVIEW';
      case ReportStatus.needsMoreInfo:
        return 'NEEDS_MORE_INFO';
      case ReportStatus.resolved:
        return 'RESOLVED';
      case ReportStatus.rejected:
        return 'REJECTED';
      case ReportStatus.closed:
        return 'CLOSED';
      case ReportStatus.archived:
        return 'ARCHIVED';
    }
  }

  static ReportStatus fromString(String value) {
    switch (value) {
      case 'NEW':
        return ReportStatus.newReport;
      case 'PENDING':
        return ReportStatus.pending;
      case 'UNDER_REVIEW':
        return ReportStatus.underReview;
      case 'NEEDS_MORE_INFO':
        return ReportStatus.needsMoreInfo;
      case 'RESOLVED':
        return ReportStatus.resolved;
      case 'REJECTED':
        return ReportStatus.rejected;
      case 'CLOSED':
        return ReportStatus.closed;
      case 'ARCHIVED':
        return ReportStatus.archived;
      default:
        throw Exception('Unknown ReportStatus: $value');
    }
  }

  String get arabicName {
    switch (this) {
      case ReportStatus.newReport:
        return 'جديد';
      case ReportStatus.pending:
        return 'قيد الانتظار';
      case ReportStatus.underReview:
        return 'قيد المراجعة';
      case ReportStatus.needsMoreInfo:
        return 'يحتاج لمزيد من المعلومات';
      case ReportStatus.resolved:
        return 'تم الحل';
      case ReportStatus.rejected:
        return 'مرفوض';
      case ReportStatus.closed:
        return 'مغلق';
      case ReportStatus.archived:
        return 'مؤرشف';
    }
  }
}
