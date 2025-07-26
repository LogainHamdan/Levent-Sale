import 'package:Levant_Sale/src/modules/sections/ui/screens/cars-sections/widgets/car-row.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';

class CarSection extends StatelessWidget {
  const CarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAdChooseSectionProvider>(
      builder: (context, provider, child) {
        print('Building CarSection with ${provider.cars.length} cars'); // Debug
        if (provider.isLoading) {
          return Center(child: CustomCircularProgressIndicator());
        }
        if (provider.cars.isEmpty) {
          return Center(child: Text('No cars found'));
        }
        return ListView.builder(
          itemCount: provider.cars.length,
          itemBuilder: (context, index) {
            return CarRow(car: provider.cars[index]);
          },
        );
      },
    );
  }
}
