import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ads/ads.dart';
import '../../ads/widgets/products-details.dart';

class CustomDraggableScrollableSheet extends StatelessWidget {
  const CustomDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.1,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: grey7,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.call, color: kprimaryColor),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "بسمة باسم",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "عضو منذ يناير 2024",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/imgs_icons/home/assets/imgs/بسمة.png'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                  text: 'محادثة',
                  onPressed: () {},
                  backgroundColor: kprimaryColor,
                  textColor: Colors.white,
                  date: false,
                  notText: true),
              SizedBox(height: 20.h),
              ProductsDetails(),
            ],
          ),
        );
      },
    );
  }
}
