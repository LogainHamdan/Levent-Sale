import '../../../../../config/constants.dart';

// final List<Map<String, String>> products = [
//   // وظائف
//   {
//     'name': 'مطلوب مصمم جرافيك',
//     'image': jobsIcon,
//     'price': '\$1500',
//     'description': 'فرصة رائعة لمصممي الجرافيك المبدعين للعمل ضمن فريق محترف.',
//   },
//   {
//     'name': 'فرصة عمل مهندس برمجيات',
//     'image': jobsIcon,
//     'price': '\$1500',
//     'description': 'وظيفة مميزة لمهندسي البرمجيات ببيئة عمل إبداعية.',
//   },
//
//   // اجهزة الكمبيوتر
//   {
//     'name': 'لابتوب ديل إنسبايرون',
//     'image': computerIcon,
//     'price': '\$850',
//     'description': 'لابتوب قوي بأداء متميز مناسب للطلاب والمحترفين.',
//   },
//   {
//     'name': 'سماعات أذن لاسلكية',
//     'image': computerIcon,
//     'price': '\$120',
//     'description': 'سماعات عالية الجودة بصوت نقي وتقنية عزل الضوضاء.',
//   },
//
//   // خدمات
//   {
//     'name': 'خدمات تصميم مواقع',
//     'image': servicesIcon,
//     'price': '\$1500',
//     'description': 'تصميم مواقع إلكترونية احترافية بأحدث التقنيات.',
//   },
//   {
//     'name': 'خدمات الترجمة الاحترافية',
//     'image': servicesIcon,
//     'price': '\$1500',
//     'description': 'ترجمة دقيقة من وإلى عدة لغات بأعلى جودة.',
//   },
//
//   // سفر
//   {
//     'name': 'رحلة سياحية إلى باريس',
//     'image': travelIcon,
//     'price': '\$1500',
//     'description': 'رحلة رائعة تشمل زيارة لأشهر معالم باريس.',
//   },
//   {
//     'name': 'باقة سياحية إلى تركيا',
//     'image': travelIcon,
//     'price': '\$1200',
//     'description': 'جولة سياحية مذهلة تشمل إسطنبول وكابادوكيا.',
//   },
//
//   // العاب
//   {
//     'name': 'بلاي ستيشن 5',
//     'image': gamesIcon,
//     'price': '\$500',
//     'description': 'جهاز الألعاب الأشهر بتجربة لعب استثنائية.',
//   },
//   {
//     'name': 'لعبة FIFA 24',
//     'image': gamesIcon,
//     'price': '\$60',
//     'description': 'لعبة كرة القدم الأكثر شعبية بإصدارها الجديد.',
//   },
//
//   // حيوانات
//   {
//     'name': 'قط شيرازي صغير',
//     'image': animalsIcon,
//     'price': '\$300',
//     'description': 'قط أليف ذو فرو ناعم وشخصية ودودة.',
//   },
//   {
//     'name': 'ببغاء متكلم',
//     'image': animalsIcon,
//     'price': '\$250',
//     'description': 'ببغاء ذكي قادر على تقليد الأصوات والتفاعل.',
//   },
//
//   // اطعمة
//   {
//     'name': 'عسل نقي 100%',
//     'image': foodIcon,
//     'price': '\$25',
//     'description': 'عسل طبيعي بجودة عالية وصحة مضمونة.',
//   },
//   {
//     'name': 'تمر مجدول فاخر',
//     'image': foodIcon,
//     'price': '\$20',
//     'description': 'تمر لذيذ بقوام طري ومذاق رائع.',
//   },
//
//   // الصحة والجمال
//   {
//     'name': 'كريم تفتيح البشرة',
//     'image': healthAndBeautyIcon,
//     'price': '\$15',
//     'description': 'كريم فعال لتفتيح البشرة ومنحها نضارة.',
//   },
//   {
//     'name': 'عطر فرنسي فاخر',
//     'image': healthAndBeautyIcon,
//     'price': '\$50',
//     'description': 'عطر مميز برائحة تدوم طويلاً.',
//   },
//
//   // مجوهرات
//   {
//     'name': 'خاتم ذهب عيار 18',
//     'image': accessoriesIcon,
//     'price': '\$300',
//     'description': 'خاتم أنيق بتصميم فاخر وجذاب.',
//   },
//   {
//     'name': 'سلسلة فضة رجالية',
//     'image': accessoriesIcon,
//     'price': '\$120',
//     'description': 'سلسلة عصرية مصنوعة من الفضة النقية.',
//   },
//   // الاجهزة
//
//   {
//     'name': 'iPhone XR',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون6.png',
//     'price': '\$500',
//     'description': 'iPhone XR بشاشة Liquid Retina وأداء ممتاز بسعر معقول.',
//   },
//   {
//     'name': 'iPhone 15 Pro Max',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون 7.png',
//     'price': '\$1300',
//     'description':
//         'أحدث iPhone 15 Pro Max بتصميم من التيتانيوم ومعالج A17 Pro.',
//   },
//   {
//     'name': 'iPhone 14 Plus',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون8.png',
//     'price': '\$1100',
//     'description': 'iPhone 14 Plus بشاشة كبيرة وبطارية تدوم طوال اليوم.',
//   },
//   {
//     'name': 'iPhone 13 Pro Max',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون1.png',
//     'price': '\$1100',
//     'description':
//         'هاتف iPhone 13 Pro Max مع شاشة Super Retina XDR وكاميرا احترافية.',
//   },
//   {
//     'name': 'iPhone 12 Pro',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون2.png',
//     'price': '\$900',
//     'description':
//         'iPhone 12 Pro بتصميم أنيق، ومعالج A14 Bionic لتجربة أداء مذهلة.',
//   },
//   {
//     'name': 'iPhone 11',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون3.png',
//     'price': '\$650',
//     'description': 'iPhone 11 بشاشة Liquid Retina ومعالج A13 Bionic القوي.',
//   },
//   {
//     'name': 'iPhone SE (2022)',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون4.png',
//     'price': '\$450',
//     'description':
//         'iPhone SE (الجيل الثالث) بمعالج A15 Bionic بحجم صغير وأداء قوي.',
//   },
//   {
//     'name': 'iPhone 14 Pro',
//     'image': 'assets/imgs_icons/home/assets/imgs/ايفون5.png',
//     'price': '\$1200',
//     'description':
//         'iPhone 14 Pro مع ميزة Dynamic Island وكاميرا بدقة 48 ميجابكسل.',
//   },
// ];

//final List<String> productImages = products.map((p) => p['image']!).toList();

final List<String> names = ['محمد', 'منال', 'بسمة'];
final List<String> images = [
  'assets/imgs_icons/home/assets/imgs/محمد.png',
  'assets/imgs_icons/home/assets/imgs/منال.png',
  'assets/imgs_icons/home/assets/imgs/بسمة.png'
];
final List<bool> onlineStatus = [true, false, true]; // Example online status
