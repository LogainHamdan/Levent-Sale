import 'dart:convert';
import 'dart:io';
import 'package:Levant_Sale/src/modules/sections/models/getAdDTO.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import '../../../config/constants.dart';
import '../models/ad.dart';
import 'package:http_parser/http_parser.dart';

import '../models/adDTO.dart';
import '../models/filter.dart';
import '../models/filter_models.dart';
import '../models/filter_type.dart';

class AdRepository {
  late final Dio dio;
  static final AdRepository _instance = AdRepository._internal();

  AdRepository._internal() {
    dio = Dio();
    _setupDio();
  }

  factory AdRepository() => _instance;

  void _setupDio() {
    dio.options.connectTimeout = Duration(seconds: 30);
    dio.options.receiveTimeout = Duration(seconds: 30);
    dio.options.sendTimeout = Duration(seconds: 30);

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print('🌐 API: $object'),
      ),
    );
  }

  // ===== EXISTING METHODS (unchanged) =====

  Future<Response> createAd({
    required AdDTO adDTO,
    List<File>? files,
    required String token,
  }) async {
    try {
      print('📤 Creating ad: ${adDTO.toJson()}');
      final formData = FormData();

      formData.files.add(MapEntry(
        'adDTO',
        MultipartFile.fromBytes(
          utf8.encode(json.encode(adDTO)),
          filename: 'ad.json',
          contentType: MediaType('application', 'json'),
        ),
      ));

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(
                file.path,
                filename: basename(file.path),
              ),
            ));
          } else {
            print('⚠️ الملف غير موجود: ${file.path}');
          }
        }
      } else {
        formData.files.add(MapEntry(
          'files',
          MultipartFile.fromBytes([], filename: ''),
        ));
      }

      final response = await dio.post(
        createAdUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('✅ Ad created successfully: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('❌ Dio error creating ad: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error creating ad: $e');
      rethrow;
    }
  }

  Future<Response> deleteAd({
    required int id,
    required String token,
  }) async {
    try {
      final response = await dio.delete(
        '$deleteAdUrl/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      print('✅ Ad deleted successfully: $id');

      return response;
    } on DioException catch (e) {
      print('❌ Dio error deleting ad: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Response> updateAd(AdDTO adDTO,
      List<File>? files, {
        required int id,
        required String token,
      }) async {
    try {
      print('📤 Updating ad $id: ${adDTO.toJson()}');
      print(files);
      final formData = FormData();

      formData.files.add(MapEntry(
        'adDTO',
        MultipartFile.fromBytes(
          utf8.encode(json.encode(adDTO)),
          filename: 'ad.json',
          contentType: MediaType('application', 'json'),
        ),
      ));

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(
                file.path,
                filename: basename(file.path),
              ),
            ));
          } else {
            print('⚠️ الملف غير موجود: ${file.path}');
          }
        }
      } else {
        formData.files.add(MapEntry(
          'files',
          MultipartFile.fromBytes([], filename: '.jpg'),
        ));
      }

      final response = await dio.put(
        '$updateAdUrl/$id',
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
            'Accept': '*/*',
          },
        ),
      );

      print('✅ Ad updated successfully: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('❌ Dio error updating ad: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error updating ad: $e');
      rethrow;
    }
  }

  Future<Response> getAds(
      {String? token, int page = 0, int size = 8, List<int>? ids}) async {
    try {
      final response = await dio.get(adsUrl,
          queryParameters: {
            'page': page,
            'size': size,
            if (ids != null) 'ids': ids,
          },
          options: Options(headers: {
            'Authorization': token,
          }));
      return response;
    } catch (e) {
      print('❌ Error getting ads: $e');
      throw Exception('Repository API error: $e');
    }
  }

  Future<Response> getCategoryAds(FilterRequestDTO filter, {
    required String categoryId,
    String? token,
    int? size,
    int? page,
  }) async {
    try {
      final response = await dio.post(
        '$getCategoryAdsUrl/$categoryId',
        data: filter.toJson(),
        queryParameters: {'page': page, 'size': size},
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ),
      );
      print('✅ Category ads fetched for $categoryId: ${response.data}');
      return response;
    } catch (e) {
      if (e is DioException) {
        print('❌ DioError getting category ads: ${e.message}');
        print('Response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('❌ Unknown error getting category ads: $e');
      }
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<AdModel>> getUserAds({required int userId}) async {
    try {
      final response = await dio.get('$getUserAdsUrl/$userId',
          options: Options(headers: {'Accept': '*/*'}));

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data.map((json) => AdModel.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format: expected a list');
        }
      } else {
        throw Exception('Failed to load ads: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error getting user ads: $e');
      throw Exception('Repository API error: $e');
    }
  }

  Future<AdModel?> getAdById({required int id}) async {
    try {
      final response = await dio.get("$getAdUrl/$id");
      print("✅ Fetching ad $id: ${response.statusCode}");
      if (response.statusCode == 200) {
        return AdModel.fromJson(response.data);
      } else {
        print('❌ Failed to get ad. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Error getting ad by id: $e');
      throw Exception('Repository API error: $e');
    }
  }

  Future<GetAdDTO?> getAdByIdForMap({required int id}) async {
    try {
      final response = await dio.get("$getAdUrl/$id");

      if (response.statusCode == 200) {
        return GetAdDTO.fromJson(response.data);
      } else {
        print('❌ Failed to get ad for map. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Error getting ad by id for map: $e');
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<AdModel?>> getMyAdsByStatus({
    required String token,
    required String status,
    int? page,
    int? size,
  }) async {
    try {
      final response = await dio.get(
        '$getAdsByStatus',
        queryParameters: {'status': status, 'page': page, 'size': size},
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print('✅ $status ads fetched successfully');

      final content = response.data['content'];

      if (content == null || content is! List) {
        print('⚠️ No ads found or invalid format');
        return [];
      }

      final ads = content.map<AdModel>((e) => AdModel.fromJson(e)).toList();
      return ads;
    } on DioException catch (e) {
      print('❌ Error fetching ads by status: ${e.response?.statusCode}');
      print('Message: ${e.response?.data}');
      rethrow;
    }
  }

  // ===== HIERARCHICAL NAVIGATION METHODS =====

  Future<Response> getCategoryChildren({
    required int categoryId,
    String? token,
  }) async {
    try {
      final url = '$baseUrl/ads/get/category/children/$categoryId';

      print('🔍 Getting category children for ID: $categoryId');
      print('🌐 URL: $url');

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ Category children fetched for $categoryId - Status: ${response.statusCode}');
      print('📊 Response data type: ${response.data.runtimeType}');

      return response;
    } on DioException catch (e) {
      print('❌ Error fetching category children: ${e.message}');
      print('❌ Status code: ${e.response?.statusCode}');
      print('❌ Response data: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Response> getCategoryChildrenWithStats({
    required int categoryId,
    String? token,
  }) async {
    try {
      final statsUrl = '$baseUrl/ads/get/category/children/$categoryId?includeStats=true';

      print('📊 Attempting to get category children with stats for ID: $categoryId');
      print('🌐 URL: $statsUrl');

      final response = await dio.get(
        statsUrl,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ Category children with stats fetched - Status: ${response.statusCode}');
      return response;

    } on DioException catch (e) {
      print('⚠️ Stats endpoint failed (${e.response?.statusCode}), falling back to regular method');


      return await getCategoryChildren(categoryId: categoryId, token: token);
    }
  }

  Future<Response> getCategoryFilters({
    required int categoryId,
    String? token,
  }) async {
    try {
      final url = '$baseUrl/search/filters/category/$categoryId';

      print('🔍 Getting category filters for ID: $categoryId');
      print('🌐 URL: $url');

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            // السماح بـ 404 كحالة طبيعية (لا توجد فلاتر)
            return status != null && (status < 300 || status == 404);
          },
        ),
      );

      if (response.statusCode == 200) {
        print('✅ Category filters fetched for $categoryId');
      } else if (response.statusCode == 404) {
        print('⚠️ No filters available for category $categoryId (404)');
      }

      return response;
    } on DioException catch (e) {
      print('❌ getCategoryFilters failed: ${e.message}');
      print('❌ Status code: ${e.response?.statusCode}');
      rethrow;
    }
  }


  Future<Response> searchAdsByCategory({
    required String categoryId,
    required Map<String, dynamic> selectedFilters,
    String? token,
    int? page,
    int? size,
  }) async {
    try {
      final url = '$baseUrl/search/ads/category/$categoryId';
      final cleanFilters = <String, dynamic>{};
      selectedFilters.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty) {
          cleanFilters[key] = value;
        }
      });

      final requestBody = {
        'filters': cleanFilters,
        'searchAttributes': <String>[],
      };

      final queryParams = <String, dynamic>{};
      if (page != null) queryParams['page'] = page;
      if (size != null) queryParams['size'] = size;

      print('🔍 Searching ads in category $categoryId');
      print('📦 Request body: $requestBody');
      print('📄 Query params: $queryParams');

      final response = await dio.post(
        url,
        data: requestBody,
        queryParameters: queryParams,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final totalElements = response.data?['totalElements'] ?? 0;
      print('✅ Search completed: $totalElements results found');

      return response;
    } on DioException catch (e) {
      print('❌ searchAdsByCategory failed: ${e.message}');
      print('❌ Response data: ${e.response?.data}');
      print('❌ Status code: ${e.response?.statusCode}');
      rethrow;
    }
  }

  /// ✅ الحصول على عدد الإعلانات في القسم مع الفلاتر
  Future<int> getAdsCountForCategory({
    required String categoryId,
    Map<String, dynamic>? filters,
    String? token,
  }) async {
    try {
      // محاولة endpoint مخصص للعد أولاً
      final countUrl = '$baseUrl/search/ads/category/$categoryId/count';

      final cleanFilters = <String, dynamic>{};
      if (filters != null) {
        filters.forEach((key, value) {
          if (value != null && value.toString().isNotEmpty) {
            cleanFilters[key] = value;
          }
        });
      }

      final requestBody = {
        'filters': cleanFilters,
        'searchAttributes': <String>[],
        'countOnly': true,
      };

      print('🔢 Getting ads count for category $categoryId with filters: $cleanFilters');

      try {
        final response = await dio.post(
          countUrl,
          data: requestBody,
          options: Options(
            headers: {
              if (token != null) 'Authorization': token,
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200) {
          final data = response.data;

          if (data is Map<String, dynamic>) {
            final count = data['count'] ?? data['totalElements'] ?? data['total'] ?? 0;
            print('✅ Count from dedicated endpoint: $count');
            return count;
          } else if (data is int) {
            print('✅ Count from dedicated endpoint: $data');
            return data;
          }
        }
      } catch (e) {
        print('⚠️ Dedicated count endpoint failed, using fallback');
      }

      // Fallback: استخدام البحث العادي مع حجم صغير
      print('🔄 Using search fallback for count');
      final searchResponse = await searchAdsByCategory(
        categoryId: categoryId,
        selectedFilters: cleanFilters,
        token: token,
        page: 0,
        size: 1, // حجم صغير فقط للحصول على العدد الإجمالي
      );

      final totalElements = searchResponse.data?['totalElements'] ?? 0;
      print('✅ Count from search fallback: $totalElements');
      return totalElements;

    } catch (e) {
      print('❌ Error fetching ads count: $e');
      return 0;
    }
  }

  // ===== STATISTICS METHODS =====





  List<DynamicFilter> parseFilters(dynamic data) {
    try {
      if (data == null) return [];

      print('🔍 Parsing filters data: $data');

      // معالجة التنسيق الجديد من API
      if (data is Map<String, dynamic>) {
        if (data['filterValue'] is List) {
          final filterValueList = data['filterValue'] as List;

          final filters = filterValueList.asMap().entries.map((entry) {
            final index = entry.key;
            final filterData = entry.value as Map<String, dynamic>;

            return _parseFilterFromNewFormat(filterData, index);
          }).toList();

          print('✅ Parsed ${filters.length} filters from new format');
          return filters;
        }
        // تنسيقات أخرى
        else if (data['filters'] is List) {
          final filtersData = data['filters'] as List;
          return filtersData
              .map((filterJson) => DynamicFilter.fromJson(filterJson as Map<String, dynamic>))
              .toList();
        }
        else if (data['data'] is List) {
          final filtersData = data['data'] as List;
          return filtersData
              .map((filterJson) => DynamicFilter.fromJson(filterJson as Map<String, dynamic>))
              .toList();
        }
      }
      else if (data is List) {
        return data
            .map((filterJson) => DynamicFilter.fromJson(filterJson as Map<String, dynamic>))
            .toList();
      }

      print('⚠️ No filters found in data');
      return [];
    } catch (e) {
      print('❌ Error parsing filters: $e');
      print('❌ Data: $data');
      return [];
    }
  }

  DynamicFilter _parseFilterFromNewFormat(Map<String, dynamic> filterData, int index) {
    final name = filterData['name'] as String? ?? 'فلتر ${index + 1}';
    final type = filterData['type'] as String? ?? 'text';

    FilterType filterType;
    switch (type.toLowerCase()) {
      case 'number':
        filterType = FilterType.number;
        break;
      case 'dropdown':
        filterType = FilterType.dropdown;
        break;
      case 'checkbox':
        filterType = FilterType.checkbox;
        break;
      case 'range':
        filterType = FilterType.range;
        break;
      case 'text':
      default:
        filterType = FilterType.text;
        break;
    }

    List<FilterOption> options = [];
    if (filterData['options'] is List) {
      final optionsList = filterData['options'] as List;
      options = optionsList.asMap().entries.map((entry) {
        final optionIndex = entry.key;
        final optionValue = entry.value;

        return FilterOption(
          id: optionIndex.toString(),
          name: optionValue.toString(),
          value: optionValue.toString(),
          isSelected: false,
        );
      }).toList();
    }

    return DynamicFilter(
      id: 'filter_$index',
      name: name,
      label: name,
      type: filterType,
      options: options,
      description: null,
    );
  }

  String _generateFilterName(String label) {
    switch (label) {
      case 'عدد السيارات المتاحة':
        return 'available_cars_count';
      case 'جهة البيع':
        return 'seller_type';
      case 'حالة السيارة':
        return 'car_condition';
      case 'نوع الوقود':
        return 'fuel_type';
      case 'سنة الصنع':
        return 'manufacturing_year';
      case 'المحرك':
        return 'engine';
      case 'ناقل الحركة':
        return 'transmission';
      case 'اللون':
        return 'color';
      case 'السعر':
        return 'price';
      case 'المسافة المقطوعة':
        return 'mileage';
      default:
        return label
            .replaceAll(' ', '_')
            .replaceAll('ة', 'a')
            .replaceAll('ال', '')
            .toLowerCase();
    }
  }

  CategoryInfo? parseCategoryInfo(dynamic data) {
    try {
      if (data == null) return null;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('id') && data.containsKey('name')) {
          return CategoryInfo.fromJson(data);
        }
        if (data.containsKey('data')) {
          return CategoryInfo.fromJson(data['data'] as Map<String, dynamic>);
        }
        if (data.containsKey('category')) {
          return CategoryInfo.fromJson(data['category'] as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      print('❌ Error parsing category info: $e');
      return null;
    }
  }

  CategoryInfo? parseCategoryInfoWithStats(dynamic data) {
    try {
      if (data == null) return null;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('id') && data.containsKey('name')) {
          return CategoryInfo.fromJsonWithStats(data);
        }
        if (data.containsKey('data')) {
          return CategoryInfo.fromJsonWithStats(data['data'] as Map<String, dynamic>);
        }
        if (data.containsKey('category')) {
          return CategoryInfo.fromJsonWithStats(data['category'] as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      print('❌ Error parsing category info with stats: $e');
      return null;
    }
  }



  // ===== HELPER METHODS =====

  Future<List<MultipartFile>> _prepareFiles(List<File> images) async {
    final List<MultipartFile> multipartFiles = [];
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    for (int i = 0; i < images.length; i++) {
      final image = images[i];
      final extension = image.path.split('.').last.toLowerCase();

      multipartFiles.add(await MultipartFile.fromFile(
        image.path,
        filename: 'image_${timestamp}_$i.$extension',
        contentType: _getMediaType(extension),
      ));
    }

    return multipartFiles;
  }

  MediaType _getMediaType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return MediaType('application', 'octet-stream');
    }
  }
}