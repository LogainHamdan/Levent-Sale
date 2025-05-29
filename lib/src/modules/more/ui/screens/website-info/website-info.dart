import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/join-screen.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../home/ui/screens/home/provider.dart';

class WebsiteInfoScreen extends StatefulWidget {
  static const id = '/info';

  const WebsiteInfoScreen({super.key});

  @override
  State<WebsiteInfoScreen> createState() => _WebsiteInfoScreenState();
}

class _WebsiteInfoScreenState extends State<WebsiteInfoScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  Future<void> _fetchInfo() async {
    final provider = Provider.of<WebsiteInfoProvider>(context, listen: false);

    await provider.loadAboutUs();
    await provider.loadAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsiteInfoProvider>(
      builder: (context, provider, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          leading: SizedBox(),
          title: const TitleRow(
            noBack: true,
            title: 'عن الموقع',
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: provider.isLoading
              ? const Center(child: CustomCircularProgressIndicator())
              : JoinWebsiteInfo(),
        ),
      ),
    );
  }
}
