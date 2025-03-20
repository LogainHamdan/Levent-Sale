import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/rounded-img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.sp),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  children: [
                    RoundedImage(
                        assetPath:
                            'assets/imgs_icons/home/assets/imgs/ايفون4.png',
                        isTopLeft: true),
                    RoundedImage(
                        assetPath:
                            'assets/imgs_icons/home/assets/imgs/ايفون5.png',
                        isTopRight: true),
                    RoundedImage(
                        assetPath:
                            'assets/imgs_icons/home/assets/imgs/ايفون3.png',
                        isBottomLeft: true),
                    RoundedImage(
                        assetPath:
                            'assets/imgs_icons/home/assets/imgs/ايفون2.png',
                        isBottomRight: true),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: grey4.withOpacity(0.6),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'الأجهزة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
