import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/widgets/follow-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatelessWidget {
  static const id = '/following';

  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return FollowTile(index: index);
            },
          ),
        ),
      ),
    );
  }
}
