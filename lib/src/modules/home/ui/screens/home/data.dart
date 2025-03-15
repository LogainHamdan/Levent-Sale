final List<String> categoryImages = [
  'assets/imgs_icons/sections/assets/imgs/عقارات.png',
  'assets/imgs_icons/sections/assets/imgs/مركبات.png',
  'assets/imgs_icons/sections/assets/imgs/اثاث.png',
  'assets/imgs_icons/sections/assets/imgs/وظائف.png',
  'assets/imgs_icons/sections/assets/imgs/اجهزة الكمبيوتر.png',
  'assets/imgs_icons/sections/assets/imgs/ملابس.png',
];

final List<String> categoryNames = [
  'العقارات',
  'المركبات',
  'الأثاث',
  'الوظائف',
  'الإلكترونيات',
  'الملابس'
];

final List<Map<String, String>> products = [
  // إلكترونيات
  {
    'name': 'ايفون 14 برو ماكس',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون1.png',
    'price': '\$41.1',
    'description': 'هاتف ذكي بأحدث المواصفات وتقنيات الكاميرا الاحترافية.',
  },
  {
    'name': 'ايفون 13 برو',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون2.png',
    'price': '\$39.9',
    'description': 'أداء قوي وتصميم أنيق مع شاشة Super Retina XDR.',
  },
  {
    'name': 'ايفون 12 ميني',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون3.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },
  {
    'name': 'ايفون 15 ميني',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون4.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },
  {
    'name': 'ايفون 7 ميني',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون5.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },
  {
    'name': 'ايفون 8 ميني',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون6.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },
  {
    'name': 'ايفون 11 ميني',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون 7.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },
  {
    'name': 'ايفون 11 برو',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون8.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },
  {
    'name': 'ايفون 11 برو ماكس',
    'image': 'assets/imgs_icons/home/assets/imgs/ايفون1.png',
    'price': '\$35.5',
    'description': 'هاتف صغير الحجم بأداء عالي وكاميرا مزدوجة.',
  },

  // مركبات
  {
    'name': 'مركبة رياضية حمراء',
    'image': 'assets/imgs_icons/sections/assets/imgs/مركبات.png',
    'price': '\$22000',
    'description': 'سيارة رياضية بتصميم أنيق وأداء سريع لمحبي المغامرة.',
  },
  {
    'name': 'دراجة نارية سوداء',
    'image': 'assets/imgs_icons/sections/assets/imgs/مركبات.png',
    'price': '\$5000',
    'description': 'دراجة نارية قوية بتصميم عصري وسرعة مذهلة.',
  },

  // أثاث
  {
    'name': 'كرسي مريح للمنزل',
    'image': 'assets/imgs_icons/sections/assets/imgs/اثاث.png',
    'price': '\$200',
    'description': 'كرسي فاخر يوفر أقصى درجات الراحة بتصميم أنيق.',
  },
  {
    'name': 'مكتب عصري أنيق',
    'image': 'assets/imgs_icons/sections/assets/imgs/اثاث.png',
    'price': '\$450',
    'description': 'مكتب أنيق بمساحة واسعة وتصميم عصري مثالي للعمل.',
  },

  // عقارات
  {
    'name': 'شقة سكنية حديثة',
    'image': 'assets/imgs_icons/sections/assets/imgs/عقارات.png',
    'price': '\$130000',
    'description': 'شقة سكنية بتصميم حديث وموقع استراتيجي رائع.',
  },
  {
    'name': 'فيلا فاخرة بمسبح',
    'image': 'assets/imgs_icons/sections/assets/imgs/عقارات.png',
    'price': '\$400000',
    'description': 'فيلا فاخرة بمساحة واسعة ومسبح خاص لراحة لا مثيل لها.',
  },

  // وظائف
  {
    'name': 'مطلوب مصمم جرافيك',
    'image': 'assets/imgs_icons/sections/assets/imgs/وظائف.png',
    'price': 'راتب شهري',
    'description': 'فرصة رائعة لمصممي الجرافيك المبدعين للعمل ضمن فريق محترف.',
  },
  {
    'name': 'فرصة عمل مهندس برمجيات',
    'image': 'assets/imgs_icons/sections/assets/imgs/وظائف.png',
    'price': 'راتب تنافسي',
    'description': 'وظيفة مميزة لمهندسي البرمجيات ببيئة عمل إبداعية.',
  },
];
final List<String> productImages = products.map((p) => p['image']!).toList();

final List<String> names = ['محمد', 'منال', 'بسمة'];
final List<String> images = [
  'assets/imgs_icons/home/assets/imgs/محمد.png',
  'assets/imgs_icons/home/assets/imgs/منال.png',
  'assets/imgs_icons/home/assets/imgs/بسمة.png'
];
final List<bool> onlineStatus = [true, false, true]; // Example online status
