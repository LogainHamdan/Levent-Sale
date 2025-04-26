import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import 'detail-row.dart';

class DetailsSection extends StatelessWidget {
  final AdModel ad;
  const DetailsSection({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // Ensures full RTL layout
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Column(
            children: [
              DetailRow(
                  title: 'النوع', value: ad.adType ?? 'NA', bgColor: grey8),
              DetailRow(
                  title: 'الحالة', value: ad.condition ?? 'NA', bgColor: grey6),
              DetailRow(
                title: 'نوع السعر',
                value: ad.negotiable != null
                    ? (ad.negotiable! ? 'قابل للنقاش' : 'غير قابل للنقاش')
                    : 'NA',
                bgColor: grey8,
              ),
              DetailRow(
                  title: 'رقم الإعلان', value: ad.adNo ?? 'NA', bgColor: grey6),
              DetailRow(
                  title: 'الوصف',
                  value: ad.description ?? 'NA',
                  bgColor: grey8),
              DetailRow(
                  title: 'السعر',
                  value: ad.price != null ? ad.price.toString() : 'NA',
                  bgColor: grey6),
              DetailRow(
                  title: 'العملة', value: ad.currency ?? 'NA', bgColor: grey8),
              DetailRow(
                  title: 'المحافظة',
                  value: ad.governorate ?? 'NA',
                  bgColor: grey6),
              DetailRow(
                  title: 'المدينة', value: ad.city ?? 'NA', bgColor: grey8),
              DetailRow(
                  title: 'العنوان الكامل',
                  value: ad.fullAddress ?? 'NA',
                  bgColor: grey6),
              DetailRow(
                  title: 'تاريخ الإنشاء',
                  value: ad.createdAt?.toString() ?? 'NA',
                  bgColor: grey8),
              DetailRow(
                  title: 'تاريخ التحديث',
                  value: ad.updatedAt?.toString() ?? 'NA',
                  bgColor: grey6),
              DetailRow(
                  title: 'إمكانية المبادلة',
                  value: ad.tradePossible != null
                      ? (ad.tradePossible! ? 'نعم' : 'لا')
                      : 'NA',
                  bgColor: grey8),
              DetailRow(
                  title: 'طريقة التواصل المفضلة',
                  value: ad.preferredContactMethod ?? 'NA',
                  bgColor: grey6),
              DetailRow(
                  title: 'رقم التواصل',
                  value: ad.contactPhone ?? 'NA',
                  bgColor: grey8),
              DetailRow(
                  title: 'البريد الإلكتروني',
                  value: ad.contactEmail ?? 'NA',
                  bgColor: grey6),
              // يمكنك إضافة مزيد بناءً على ما تريده من attributes مثلاً
            ],
          ),
        ],
      ),
    );
  }
}
