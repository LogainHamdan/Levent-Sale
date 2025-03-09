// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sellha/src/modules/auth/auth_router.dart';
// import '../../../managers/navigation_manager.dart';
//
// class CustomInterceptor extends Interceptor {
//   // on request.
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     debugPrint('method : ${options.method}');
//     debugPrint('url : ${options.path}');
//     debugPrint('headers : ${options.headers}');
//     debugPrint('data : ${options.data}');
//     debugPrint('queryParameters : ${options.queryParameters}');
//     return super.onRequest(options, handler);
//   }
//
//   // on response.
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     debugPrint('status code : ${response.statusCode}');
//     debugPrint('response : ${response.data}');
//     if (response.statusCode != null && response.statusCode == 401) {
//       N.offAllNamed(AuthRouter.signInScreen);
//
//       handler.resolve(response.data);
//     }
//     return super.onResponse(response, handler);
//   }
//
