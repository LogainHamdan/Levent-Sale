import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/cars-sections/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../models/car.dart';

class CarRow extends StatelessWidget {
  final Car car;

  const CarRow({required this.car});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarSectionProvider>(context);
    final isSelected = provider.isSelected(car);

    return GestureDetector(
      onTap: () => provider.selectVehicle(car),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.w),
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _infoText('Vehicle Class', bold: true)),
                Expanded(child: _infoText('Drive', bold: true)),
                Expanded(child: _infoText('Cylinder', bold: true)),
                Expanded(child: _infoText('MPG (city)', bold: true)),
                Expanded(child: _infoText('Fuel', bold: true)),
                Expanded(child: _infoText('#', bold: true)),
              ],
            ),
            Divider(color: dividerColor, thickness: 1.h),
            Row(
              children: [
                Expanded(child: _infoText(car.vehicleSizeClass)),
                Expanded(child: _infoText(car.drive)),
                Expanded(child: _infoText(car.cylinders.toString())),
                Expanded(child: _infoText(car.cityMpqForFuelType1.toString())),
                Expanded(child: _infoText(car.fuelType1)),
                Radio<Car>(
                  value: car,
                  groupValue: provider.selectedCar,
                  onChanged: (_) => provider.selectVehicle(car),
                  activeColor: kprimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoText(String text, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: bold ? FontWeight.bold : FontWeight.w400,
        ),
      ),
    );
  }
}
