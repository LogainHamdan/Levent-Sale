import 'package:Levant_Sale/src/modules/sections/models/reportDTO.dart';
import 'package:dio/dio.dart';

import '../../../config/constants.dart';
import '../../more/models/profile.dart';
import '../models/report.dart';

class ReportRepository {
  late final Dio dio;
  static final ReportRepository _instance = ReportRepository._internal();

  ReportRepository._internal() {
    dio = Dio();
  }

  factory ReportRepository() => _instance;

  Future<List<Report>?> getUserReports({required String token}) async {
    try {
      final response = await dio.get(
        getReportsUrl,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        print('Reports loaded: ${response.data}');
        return data.map((e) => Report.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load reports: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<Response> addReport(ReportDTO report, {required String token}) async {
    try {
      final response = await dio.post(
        addReportUrl,
        data: report.toJson(),
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Report created successfully: ${response.data}');
        return response;
      } else {
        throw Exception('Failed to create report: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }
}
