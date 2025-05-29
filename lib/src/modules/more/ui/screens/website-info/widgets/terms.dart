import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../home/ui/screens/ads/widgets/title-row.dart';
import '../provider.dart';

class ConditionsAndTermsScreen extends StatefulWidget {
  static const id = '/terms';

  const ConditionsAndTermsScreen({super.key});

  @override
  State<ConditionsAndTermsScreen> createState() =>
      _ConditionsAndTermsScreenState();
}

class _ConditionsAndTermsScreenState extends State<ConditionsAndTermsScreen> {
  late Future<void> _termsFuture;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<WebsiteInfoProvider>(context, listen: false);
    _termsFuture = provider.loadTerms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: const TitleRow(
          title: 'الشروط والخصوصية',
        ),
      ),
      body: SafeArea(
        child: Consumer<WebsiteInfoProvider>(
          builder: (context, provider, child) => FutureBuilder(
            future: _termsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressIndicator();
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SingleChildScrollView(
                  child: Text(
                    provider.terms ?? '',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
