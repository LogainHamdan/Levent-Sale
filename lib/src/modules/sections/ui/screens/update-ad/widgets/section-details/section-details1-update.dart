import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/checking-container.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/custom-switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../config/constants.dart';
import '../../../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../../../models/attriburtes.dart';
import '../../provider.dart';

class SectionDetails1Update extends StatefulWidget {
  const SectionDetails1Update({super.key});

  @override
  State<SectionDetails1Update> createState() => _SectionDetails1UpdateState();
}

class _SectionDetails1UpdateState extends State<SectionDetails1Update> {
  bool isLoading = true;
  late UpdateAdSectionDetailsProvider detailsProvider;

  Future<void> _initializeData() async {
    try {
      final provider = Provider.of<UpdateAdProvider>(context, listen: false);
      detailsProvider =
          Provider.of<UpdateAdSectionDetailsProvider>(context, listen: false);
      final lastCategoryId = detailsProvider
          .extractLastCategoryId(provider.selectedAdToUpdate?.categoryPath);
      await detailsProvider.fetchAttributes(lastCategoryId ?? 0);
      detailsProvider.initializeControllers(context);
      detailsProvider.initializeSelectedValuesFromAd(
          provider.selectedAdToUpdate?.attributes);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error initializing data: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CustomCircularProgressIndicator())
        : Consumer<UpdateAdSectionDetailsProvider>(
            builder: (context, provider, _) {
            final attributesData = provider.attributesData;
            print(attributesData?.toJson());
            if (attributesData == null || attributesData.attributes == null) {
              return const Center(child: CustomCircularProgressIndicator());
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (attributesData.attributes?.fields?.isNotEmpty ?? false)
                      ...(attributesData.attributes?.fields ?? [])
                          .where((field) => field.type != null)
                          .map((field) {
                        if (field.type == null) {
                          return const SizedBox.shrink();
                        }
                        switch (field.type) {
                          case FieldType.text:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.sp,
                                            fontFamily: GoogleFonts.tajawal()
                                                .fontFamily,
                                          ),
                                        ),
                                        TextSpan(
                                          text: field.label ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontFamily: GoogleFonts.tajawal()
                                                .fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                CustomTextField(
                                  label: null,
                                  controller:
                                      provider.getController(field.name ?? ''),
                                  hint: field.placeholder,
                                  bgcolor: grey8,
                                  errorText: '',
                                ),
                                SizedBox(height: 8.h),
                              ],
                            );
                          case FieldType.number:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.sp,
                                            fontFamily: GoogleFonts.tajawal()
                                                .fontFamily,
                                          ),
                                        ),
                                        TextSpan(
                                          text: field.label ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontFamily: GoogleFonts.tajawal()
                                                .fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                CustomTextField(
                                  errorText: '',
                                  label: null,
                                  controller:
                                      provider.getController(field.name ?? ''),
                                  hint: field.placeholder,
                                  bgcolor: grey8,
                                ),
                              ],
                            );
                          case FieldType.dropdown:
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if ((field.options ?? []).isNotEmpty) ...[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14.sp,
                                                fontFamily:
                                                    GoogleFonts.tajawal()
                                                        .fontFamily,
                                              ),
                                            ),
                                            TextSpan(
                                              text: field.label ??
                                                  'عنوان غير معروف',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontFamily:
                                                    GoogleFonts.tajawal()
                                                        .fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    CustomDropdownSectionUpdate(
                                      title: null,
                                      dropdownKey: field.name ?? '',
                                      hint: field.placeholder ?? 'اختر',
                                      items: field.options ?? [],
                                      errorText: "",
                                    ),
                                    SizedBox(height: 8.h),
                                  ],
                                ]);
                          case FieldType.radio:
                            final options = field.options ?? ['نعم', 'لا'];
                            final onValue =
                                options.isNotEmpty ? options.first : 'نعم';
                            final offValue =
                                options.length > 1 ? options[1] : 'لا';
                            final currentValue =
                                provider.getSelectedValue(field.name ?? '');

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.sp,
                                            fontFamily: GoogleFonts.tajawal()
                                                .fontFamily,
                                          ),
                                        ),
                                        TextSpan(
                                          text: field.label ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontFamily: GoogleFonts.tajawal()
                                                .fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                CustomSwitchTileUpdate(
                                  title: "",
                                  value: currentValue == onValue,
                                  onChanged: (val) {
                                    final newValue = val ? onValue : offValue;
                                    (provider.setSelectedValue(
                                        field.name ?? '', newValue));
                                  },
                                  activeColor: kprimaryColor,
                                ),
                                SizedBox(height: 8.h),
                              ],
                            );

                          case FieldType.checkbox:
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CheckingContainerUpdate(),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            );
                          default:
                            return SizedBox.shrink();
                        }
                      }).toList(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          });
  }
}
