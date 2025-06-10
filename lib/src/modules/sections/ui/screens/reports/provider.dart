import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:flutter/material.dart';

import '../../../models/report.dart';
import '../../../models/reportDTO.dart';
import '../../../repos/report.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepository repo = ReportRepository();
  List<Report> _reports = [];
  bool _isLoading = false;
  Report? _selectedReport;
  bool _isReportCreated = false;
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  bool get isReportCreated => _isReportCreated;

  Report? get selectedReport => _selectedReport;
  void setSelectedReport(Report? report) {
    _selectedReport = report;
    notifyListeners();
  }

  Future<void> loadUserReports() async {
    _isLoading = true;

    try {
      final token = await TokenHelper.getToken();
      final reportsData = await repo.getUserReports(token: token ?? '');
      _reports = reportsData ?? [];
    } catch (e) {
      print('Error loading reports: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAdReport(
      int reportToId, String reason, String? description) async {
    _isReportCreated = false;

    try {
      final token = await TokenHelper.getToken();
      final report = ReportDTO(
          reportToId: reportToId,
          reason: reason,
          description: description,
          reportType: 'Ad');
      await repo.addReport(report, token: token ?? '');
      _isReportCreated = true;

      await loadUserReports();
    } catch (e) {
      print('Error adding ad report: $e');
    }
  }

  Future<void> addUserReport(
      int reportToId, String reason, String? description) async {
    _isReportCreated = false;

    try {
      final token = await TokenHelper.getToken();
      final report = ReportDTO(
          reportToId: reportToId,
          reason: reason,
          description: description,
          reportType: 'User');
      await repo.addReport(report, token: token ?? '');
      _isReportCreated = true;

      await loadUserReports();
    } catch (e) {
      print('Error adding user report: $e');
    }
  }
}
