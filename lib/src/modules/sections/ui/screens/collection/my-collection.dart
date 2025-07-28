import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-widget.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/join-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../home/ui/screens/home/provider.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../models/ad.dart';
import '../create-ad/create-ad.dart';
import '../update-ad/provider.dart';

class MyCollectionScreen extends StatelessWidget {
  static const id = '/collection';

  const MyCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyCollectionScreenProvider(),
      child: const _MyCollectionScreenBody(),
    );
  }
}

class _MyCollectionScreenBody extends StatefulWidget {
  const _MyCollectionScreenBody({Key? key}) : super(key: key);

  @override
  State<_MyCollectionScreenBody> createState() =>
      _MyCollectionScreenBodyState();
}

class _MyCollectionScreenBodyState extends State<_MyCollectionScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //    final provider = Provider.of<UpdateAdProvider>(context, listen: false);
      // context
      //     .read<CreateAdSectionDetailsProvider>()
      //     .fetchAttributes(adToUpdate.id ?? 0);
      // final adToUpdate = provider.selectedAdToUpdate ?? AdModel();
      context.read<MyCollectionScreenProvider>().fetchAllUserAds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: const TitleRow(
          noBack: true,
          title: 'تشكيلتي',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<MyCollectionScreenProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading &&
                provider.publishedAds.isEmpty &&
                provider.pendingAds.isEmpty &&
                provider.rejectedAds.isEmpty) {
              return const Center(child: CustomCircularProgressIndicator());
            }
            if (provider.publishedAds.isEmpty &&
                provider.pendingAds.isEmpty &&
                provider.rejectedAds.isEmpty) {
              return EmptyWidget(
                msg: 'إعلاناتي فارغة',
                img: emptyAdsIcon,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: CustomElevatedButton(
                    text: 'ابدأ في انشاء إعلانك',
                    onPressed: () async {
                      await Navigator.pushNamed(context, CreateAdScreen.id);
                      await provider.fetchAllUserAds();
                    },
                    backgroundColor: kprimaryColor,
                    textColor: grey9,
                    date: false,
                  ),
                ),
              );
            }
            return JoinMyCollection(
              isLoadingPublished: provider.isLoadingPublished,
              isLoadingPending: provider.isLoadingPending,
              isLoadingRejected: provider.isLoadingRejected,
              publishedAds: provider.publishedAds,
              pendingAds: provider.pendingAds,
              rejectedAds: provider.rejectedAds,
            );
          },
        ),
      ),
    );
  }
}
