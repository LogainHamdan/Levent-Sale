// import 'package:dio/dio.dart';
// import 'package:sellha/src/config/api_config/interceptors/custom_interceptor.dart';
// import 'package:sellha/src/config/constants.dart';
// import 'package:sellha/src/config/shared_data.dart';
//
// class Api {
//   static late Dio dio;
//
//   // init.
//   static void init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: Constants.apiUrl,
//         receiveTimeout: 15000,
//         connectTimeout: 15000,
//         sendTimeout: 15000,
//         contentType: Headers.jsonContentType,
//         validateStatus: (status) {
//           return true;
//         },
//         headers: headers(),
//       ),
//     )..interceptors.add(CustomInterceptor());
//   }
//
//   // headers.
//   static Map<String, dynamic> headers() => {
//         'Accept': 'application/json',
//         'Authorization': SharedData.currentUser == null
//             ? null
//             : 'Bearer ${SharedData.currentUser!.token}',
//     "Accept-Language":SharedData.appLocalization.locale
//       };
// }
