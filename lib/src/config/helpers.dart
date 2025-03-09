// import 'dart:io';
// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:sellha/src/config/core/enums.dart';
// import 'package:sellha/src/config/shared_data.dart';
// import 'package:sellha/src/managers/shared_preferences_manager.dart';
// import 'package:sellha/src/modules/_app/ui/widgets/confirmation_widget.dart';
// import 'package:sellha/src/modules/_app/ui/widgets/loading_widget.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class Helpers {
//   // show message.
//   static void showMessage({
//     required String text,
//     required MessageType messageType,
//     bool persistent = true,
//   }) {
//     showFlash(
//       context: SharedData.navigationKey!.currentContext!,
//       persistent: persistent,
//       duration: const Duration(seconds: 3),
//       builder: (_, controller) {
//         return Flash(
//           controller: controller,
//           margin: EdgeInsets.only(
//             bottom: 20.h,
//             left: 10.w,
//             right: 10.w,
//           ),
//           borderRadius: BorderRadius.circular(
//             8.r,
//           ),
//           boxShadows: kElevationToShadow[8],
//           backgroundColor: messageType == MessageType.successMessage
//               ? Colors.green
//               : Colors.red,
//           onTap: () => controller.dismiss(),
//           forwardAnimationCurve: Curves.bounceInOut,
//           reverseAnimationCurve: Curves.easeIn,
//           alignment: AlignmentDirectional.bottomCenter,
//           child: DefaultTextStyle(
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: Helpers.getFontFamily(),
//             ),
//             child: FlashBar(
//               content: Text(
//                 text,
//                 style: TextStyle(
//                   fontFamily: Helpers.getFontFamily(),
//                 ),
//               ),
//               //   leftBarIndicatorColor: Colors.red,
//               icon: Icon(
//                 messageType == MessageType.successMessage
//                     ? Icons.check
//                     : Icons.error,
//                 color: Colors.white,
//               ),
//               primaryAction: TextButton(
//                 onPressed: () => controller.dismiss(),
//                 child: Text(
//                   'DISMISS',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: Helpers.getFontFamily(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // shortcut for showing bottom sheet.
//   static Future bottomSheet({
//     required Widget child,
//     Color? backgroundColor,
//     double radius = 30,
//     bool isScrollControlled = true,
//   }) async {
//     return await showModalBottomSheet(
//       context: SharedData.navigationKey!.currentContext!,
//       builder: (_) => child,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(radius.r),
//         ),
//       ),
//       isScrollControlled: isScrollControlled,
//       backgroundColor: backgroundColor,
//     );
//   }
//
//   // show dialog.
//   static Future showADialog({
//     required Widget child,
//   }) async {
//     return await showDialog(
//       context: SharedData.navigationKey!.currentContext!,
//       builder: (_) => child,
//     );
//   }
//
//   // show loading dialog.
//   static void showLoading({
//     String? title,
//   }) {
//     showDialog(
//       context: SharedData.navigationKey!.currentContext!,
//       builder: (_) => LoadingWidget(
//         title: title,
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   // show confirmation.
//   static void showConfirmation({
//     required final String title,
//     required final String description,
//     required final String confirmText,
//     final String? iconName,
//     Color? buttonColor,
//     required final void Function() onConfirm,
//   }) {
//     showDialog(
//       context: SharedData.navigationKey!.currentContext!,
//       builder: (_) => ConfirmationWidget(
//         title: title,
//         description: description,
//         confirmText: confirmText,
//         iconName: iconName,
//         onConfirm: onConfirm,
//         buttonColor: buttonColor,
//       ),
//     );
//   }
//
//   // check if the user is signed in or not.
//   // static bool checkAuth({
//   //   required BuildContext context,
//   // }) {
//   //   if (AppSharedData.currentUser == null) {
//   //     showConfirmationDialog(
//   //       context: context,
//   //       description: 'You are not signed in to make this action'.tr,
//   //       confirmText: 'Sign In'.tr,
//   //       onConfirm: () {
//   //         N.offAllNamed(Constants.screensLandingScreen);
//   //       },
//   //     );
//   //   }
//   //   return AppSharedData.currentUser != null;
//
//   // request current user position.
//   static void requestCurrentUserPosition({
//     required final void Function(Position currentPosition) onLocationEnabled,
//     required final void Function(dynamic error) onLocationError,
//   }) async {
//     try {
//       // showLoading();
//       await Geolocator.requestPermission();
//       Position currentUserPosition = await Geolocator.getCurrentPosition();
//       // success.
//       onLocationEnabled(currentUserPosition);
//       // N.back();
//     } catch (error) {
//       // error.
//       onLocationError(error);
//       // N.back();
//       debugPrint('error : ${error.toString()}');
//     }
//   }
//
//   // open location on google map app.
//   static void openLocationOnGoogleMapApp({
//     required double lat,
//     required double lng,
//   }) async {
//     try {
//       String mapSchema = Platform.isAndroid
//           ? 'https://www.google.com/maps/search/?api=1&query=$lat,$lng'
//           // ? 'geo:$lat,$long'
//           : 'https://maps.apple.com/?q=$lat,$lng';
//       await launchUrl(Uri.parse(mapSchema));
//     } catch (error) {
//       debugPrint("couldn't launch the google map: $error");
//       Helpers.showMessage(
//           text: 'Something went wrong',
//           messageType: MessageType.failureMessage);
//     }
//   }
//
//   // get bytes from asset.
//   // static Future<Uint8List> getBytesFromAsset({
//   //   required String path,
//   //   required int width,
//   //   required int height,
//   // }) async {
//   //   ByteData data = await rootBundle.load(path);
//   //   ui.Codec codec = await ui.instantiateImageCodec(
//   //     data.buffer.asUint8List(),
//   //     targetWidth: width,
//   //     targetHeight: height,
//   //   );
//   //   ui.FrameInfo fi = await codec.getNextFrame();
//   //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//   //       .buffer
//   //       .asUint8List();
//   // }
//
//   // get current font family.
//   static String getFontFamily() =>
//       SharedPreferencesManager.instance.getAppLang() == 'en'
//           ? 'poppins'
//           : 'Avenir';
//
//   // email validator.
//   static bool isValidEmailAddress(String text) => RegExp(
//           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//       .hasMatch(text);
//
//   // mobile validator.
//   static bool isValidMobile(String text) => true;
//
//   // password validator.
//   static bool isValidPassword(String text) => text.length >= 8;
//
//   // url validator.
//   static bool isValidUrl(String text) => RegExp(
//           r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
//       .hasMatch(text);
//
//   // image encryption.
//   // static String encryptImage({
//   //   required File image,
//   // }) {
//   //   return 'data:image/${image.path.substring(image.path.lastIndexOf('.') + 1)};base64,${base64Encode(image.readAsBytesSync())}';
//   // }
//
//   // to num.
//   static num toNum(dynamic value) {
//     if (value is num) {
//       return value;
//     } else if (value is String) {
//       return num.tryParse(value) ?? 0;
//     } else {
//       return 0;
//     }
//   }
//
//   // to int.
//   static int toInt(dynamic value) {
//     if (value is int) {
//       return value;
//     } else if (value is String) {
//       return int.tryParse(value) ?? 0;
//     } else {
//       return 0;
//     }
//   }
//
//   // to double.
//   static double toDouble(dynamic value) {
//     if (value is double) {
//       return value;
//     } else if (value is String) {
//       return double.tryParse(value) ?? 0;
//     } else {
//       return 0;
//     }
//   }
//
//   // format date.
//   static String formatDate(
//     DateTime dateTime, {
//     bool withTime = false,
//   }) {
//     if (withTime) {
//       return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
//     } else {
//       return DateFormat('yyyy-MM-dd').format(dateTime);
//     }
//   }
//
//   // format time.
//   static String formatTime(
//     DateTime dateTime, {
//     bool withSeconds = false,
//   }) {
//     return withSeconds
//         ? DateFormat('hh:mm:ss').format(dateTime)
//         : DateFormat('hh:mm').format(dateTime);
//   }
//
//   // color from hexa.
//   static Color fromHexa(String hexa) {
//     hexa = hexa.replaceAll('#', '');
//     if (hexa.length == 6) {
//       hexa = "FF$hexa";
//     }
//     return Color(int.parse(hexa, radix: 16));
//   }
//
//   // convert time.
//   static String formatDateTime(DateTime datetime) {
//     DateFormat formatter = DateFormat('d-MMMM-yyyy');
//     String formattedDate = formatter.format(datetime);
//     return formattedDate;
//   }
// }
