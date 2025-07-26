import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/about-us.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/privacy-policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JoinWebsiteInfo extends StatelessWidget {
  const JoinWebsiteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WebsiteInfoProvider>(context, listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 4, // Number of// tabs
        child: Column(
          children: [
            // Tab Bar
            SizedBox(
              height: 60.h,
              child: TabBar(
                padding: EdgeInsets.zero,
                labelColor: kprimaryColor,
                indicatorColor: kprimaryColor,
                labelStyle: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Tajawal",
                        fontWeight: FontWeight.w600)),
                isScrollable: true, // Allow scrolling if tabs are too wide
                tabs: const [
                  Tab(
                    text: "من نحن",
                  ),
                  Tab(text: "سياسة الخصوصية"),
                  Tab(text: "الإعلانات الممنوعة"),
                  Tab(text: "الأسئلة الشائعة"),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Tab Bar View with content
            Expanded(
              child: TabBarView(
                children: [
                  const AboutUs(),
                  const PrivacyPolicy(),
                  // Placeholder widgets for the missing content
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "# الإعلانات الممنوعة ## مقدمة للحفاظ على بيئة آمنة وموثوقة، يُمنع نشر الإعلانات التي تتضمن ما يلي: ### قائمة الإعلانات الممنوعة (غير حصرية) - المخدرات والمواد الممنوعة. - الأسلحة والمتفجرات. - المواد الإباحية أو المخالفة للأخلاق. - السلع المقلدة أو المسروقة. - الأدوية دون وصفة. - الحيوانات المهددة بالانقراض. - المحتوى المسيء أو العنصري أو التحريضي. - الإعلانات الاحتيالية أو المضللة. - انتهاك الملكية الفكرية. - المواد الخطرة. - الإعلانات ذات الطابع السياسي أو الديني. - جمع معلومات حساسة دون مبرر. - الروابط الخبيثة. ### ملاحظات - يحتفظ الموقع بالحق في حذف أي إعلان مخالف. - قد يتم حظر حسابات المخالفين المتكررين. - نرجو الإبلاغ عن أي محتوى مشبوه. نشكر تعاونكم."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        """ # الأسئلة الشائعة ## مقدمة نقدم إجابات على أكثر الأسئلة شيوعاً. إذا لم تجد ما تبحث عنه، تواصل معنا عبر [معلومات الاتصال]. ### س: ما هو Levant Sale؟ **ج:** Levant Sale هو منصة إلكترونية في سوريا تتيح للأفراد والشركات البيع، الشراء، التأجير، أو التبرع بمختلف المنتجات والخدمات. ### س: كيف يمكنني التسجيل في الموقع؟ **ج:** من خلال الضغط على زر "تسجيل" أعلى الصفحة، واتباع التعليمات. ### س: هل استخدام الموقع مجاني؟ **ج:** نعم، معظم الميزات مجانية، وقد يتم فرض رسوم على بعض الخدمات المميزة مستقبلاً. ### س: هل يمكنني تعديل أو حذف إعلاني؟ **ج:** نعم، يمكنك إدارة إعلاناتك من خلال حسابك الشخصي. ### س: هل التبرع متاح فقط للمنظمات؟ **ج:** لا، يمكن للأفراد أيضاً التبرع عبر المنصة. ### س: كيف أبلغ عن إعلان مخالف؟ **ج:** اضغط على زر "إبلاغ" الموجود في صفحة الإعلان. ### س: هل يمكنني استخدام الموقع من خارج سوريا؟ **ج:** نعم، لكن الخدمة موجهة بشكل أساسي للسوق السوري."""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
