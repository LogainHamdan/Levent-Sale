import 'package:flutter/material.dart';

///API
const String baseUrl = "http://37.148.208.169";


///endpoints
///auth
const String logoutUrl = "$baseUrl/users/logout";
const String loginUrl = "$baseUrl/users/login";
const String googleLoginUrl = "$baseUrl/users/google-login";
const String requestUpdatePassUrl = "$baseUrl/users/request-password-reset";
const String signUpUrl = "$baseUrl/users/register";
const String signUpBusinessOwnerUrl = "$baseUrl/users/register-business-owner";
const String verifyUrl = "$baseUrl/users/verify";
const String resendVerifyUrl = "$baseUrl/users/resend-verification-code";

///follow
const String unfollowUrl = "$baseUrl/users/unfollow";
const String followUrl = "$baseUrl/users/follow";
const String followingUrl = "$baseUrl/users/following";

///profile
const String editProfileUrl = "$baseUrl/users/update-profile";
const String updatePassUrl = "$baseUrl/users/update-password";
const String updatePassTokenUrl = "$baseUrl/users/update-password-with-token";
const String updateAddressUrl = "$baseUrl/users/update-address";
const String profileUrl = "$baseUrl/users/profile";

///home
const String searchUrl = "$baseUrl/users/search";

///sections
const String getCategoriesUrl = '$baseUrl/ads/get/all/roots';
const String getCategoryByIdUrl = '$baseUrl/ads/get/category';
const String getSubcategoryUrl = '$baseUrl/ads/get/subcategories';
const String getCategoryChildrenUrl = '$baseUrl/ads/get/category/children';
const String getAttributesById = '$baseUrl/ads/attributes/category';
const String createAdUrl = '$baseUrl/ads/add';

// primary colors
Color kprimaryColor = const Color(0xff82B81C);
Color kprimary1Color = const Color(0xFF82B81C);
Color kprimary2Color = const Color(0xFFB4D477);
Color kprimary3Color = const Color(0xFFCDE3A4);
Color kprimary4Color = const Color(0xFFE6F1D2);
Color amberColor = Colors.amber;
Color dividerColor = Color(0xFF3C3C434A);

//alert & status colors
Color successColor = const Color(0xFF07BD74);
Color infoColor = const Color(0xFF246BFD);
Color warningColor = const Color(0xFFFACC15);
Color errorColor = const Color(0xFFF75555);
Color disabledColor = const Color(0xFFD8D8D8);

//grey scale
Color grey0 = const Color(0xFF212121);
Color grey1 = const Color(0xFF424242);
Color grey2 = const Color(0xFF616161);
Color grey3 = const Color(0xFF757575);
Color grey4 = const Color(0xFF9E9E9E);
Color grey5 = const Color(0xFFBDBDBD);
Color grey6 = const Color(0xFFE0E0E0);
Color grey7 = Colors.grey[100]!;
Color grey8 = const Color(0xFFF5F5F5);
Color grey9 = const Color(0xFFFAFAFA);
Color greyBlur = const Color(0xFF4242424D);

//buttons
Color greySplash = const Color(0xFFEEEEEE);
Color cancelColor = const Color(0xFFF75555);

//images, icons paths

///logo
String logo = 'assets/imgs_icons/general/logo.png';

///auth
String cancelPath = 'assets/imgs_icons/auth/assets/icons/cancel.svg';
String unseenPath = 'assets/imgs_icons/auth/assets/icons/unseen.svg';
String seenPath = 'assets/imgs_icons/auth/assets/icons/seen.png';
String facebookPath = 'assets/imgs_icons/auth/assets/imgs/facebook.svg';
String googlePath = 'assets/imgs_icons/auth/assets/imgs/google.svg';
String tickPath = 'assets/imgs_icons/auth/assets/imgs/tick.svg';
String calendarIcon = 'assets/imgs_icons/auth/assets/icons/calendar.svg';

///general
String aboveGreyPath = 'assets/imgs_icons/general/above-grey.svg';
String arrowAbovePath = 'assets/imgs_icons/general/arrow-above.svg';
String arrowDownPath = 'assets/imgs_icons/general/arrow-down.svg';
String arrowLeftPath = 'assets/imgs_icons/general/arrow-left.svg';
String arrowRightPath = 'assets/imgs_icons/general/arrow-right.svg';
String calendarArrowLeftPath = 'assets/imgs_icons/auth/assets/icons/Back.svg';
String calendarArrowRightPath =
    'assets/imgs_icons/general/calendar-arrow-right.svg';
String greyArrowDownPath = 'assets/imgs_icons/general/grey-arrow-down.svg';
String greyArrowLeftPath = 'assets/imgs_icons/general/grey-arrow-left.svg';
String greyArrowRightPath = 'assets/imgs_icons/general/grey-arrow-right.svg';

///navigation bar
String homeUnselected = 'assets/imgs_icons/general/home-2.svg';
String homeSelected = 'assets/imgs_icons/general/Vector.svg';
String sectionsUnselected = 'assets/imgs_icons/general/element-3.svg';
String sectionsSelected = 'assets/imgs_icons/general/element-4.svg';
String menuUnselected = 'assets/imgs_icons/general/menu.svg';
String menuSelected = 'assets/imgs_icons/general/menu-colored.svg';
String collectionUnselected = 'assets/imgs_icons/general/shopping-bag.svg';
String collectionSelected =
    'assets/imgs_icons/general/shopping-bag-colored.svg';
String addIcon = 'assets/imgs_icons/general/Vectorplus.svg';

///home
String callPath = 'assets/imgs_icons/home/assets/icons/call.svg';
String sendIcon = 'assets/imgs_icons/home/assets/icons/sendIcon.svg';
String favColoredPath = 'assets/imgs_icons/home/assets/icons/fav-colored.svg';
String favUncoloredPath =
    'assets/imgs_icons/home/assets/icons/fav-uncolored.svg';
String rightOfBannerPath =
    'assets/imgs_icons/home/assets/icons/right-of-banner.svg';
String iphone12Path = 'assets/imgs_icons/home/assets/imgs/iphone12.svg';
String editBlackIcon = 'assets/imgs_icons/home/assets/icons/edit.svg';
String emptyChatIcon =
    'assets/imgs_icons/home/assets/icons/ic-chat-empty 1.svg';
String searchNoResultIcon =
    'assets/imgs_icons/home/assets/icons/light_no-results.svg';
String notificationsIcon =
    'assets/imgs_icons/home/assets/icons/notification.svg';
String filterIcon = 'assets/imgs_icons/home/assets/icons/setting-4.svg';
String greenSeenIcon = 'assets/imgs_icons/home/assets/icons/Vector.svg';
String chatBlackIcon = 'assets/imgs_icons/home/assets/icons/message.svg';
String chatWhiteIcon = 'assets/imgs_icons/home/assets/icons/message1.svg';
String shareIcon = 'assets/imgs_icons/home/assets/icons/Vector-1.svg';
String photoAttachIcon =
    'assets/imgs_icons/home/assets/icons/direct-notification.svg';
String linkAttachIcon = 'assets/imgs_icons/home/assets/icons/linkAttach.svg';
String moreIcon = 'assets/imgs_icons/home/assets/icons/more.svg';
String searchIcon = 'assets/imgs_icons/home/assets/icons/search.png';
String emptyNotificationsIcon =
    'assets/imgs_icons/sections/assets/imgs/empty-notification.svg';

///sections
///
String arrowForwardCarousel = 'assets/imgs_icons/sections/assets/icons/row.svg';
String arrowBackCarousel =
    'assets/imgs_icons/sections/assets/icons/arrow-right.svg';
String addImageIcon = 'assets/imgs_icons/sections/assets/icons/img.png';
String jobsIcon =
    'assets/imgs_icons/sections/assets/imgs/9d4d6514-8c97-4267-a241-6adc0f11fc97 1.png';
String animalsIcon = 'assets/imgs_icons/sections/assets/imgs/Animals 1.png';
String clothesIcon =
    'assets/imgs_icons/sections/assets/imgs/download-removebg-preview (2) 1.png';
String booksIcons =
    'assets/imgs_icons/sections/assets/imgs/download-removebg-preview (4) 1.png';
String devicesIcon =
    'assets/imgs_icons/sections/assets/imgs/download-removebg-preview (7) 2.png';
String mixIcon = 'assets/imgs_icons/sections/assets/imgs/img_2.png';
String foodIcon = 'assets/imgs_icons/sections/assets/imgs/Food 1.png';
String gamesIcon = 'assets/imgs_icons/sections/assets/imgs/Gaming 1.png';
String furnitureIcon =
    'assets/imgs_icons/sections/assets/imgs/images-removebg-preview 1.png';
String carsIcon = 'assets/imgs_icons/sections/assets/imgs/image 17.png';
String propertiesIcon =
    'assets/imgs_icons/sections/assets/imgs/Properties 3.png';
String servicesIcon = 'assets/imgs_icons/sections/assets/imgs/Services 1.png';
String emptyAdsIcon =
    'assets/imgs_icons/sections/assets/icons/shopping-bag.svg';
String sportsIcon = 'assets/imgs_icons/sections/assets/imgs/Sports 1.png';
String travelIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_X_MOr6oa4-k-removebg-preview 1.png';
String industryIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_4_Bgqgl8TiU-removebg-preview 1.png';
String accessoriesIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_202NAwjisYA-removebg-preview 1.png';
String makeupIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_EyrjiJAwLjQ-removebg-preview 1.png';
String motherAndKidIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_Z4GKcFAGck4-removebg-preview 1.png';
String computerIcon = 'assets/imgs_icons/sections/assets/imgs/img_1.png';
String mobileIcon = 'assets/imgs_icons/sections/assets/imgs/img.png';
String cultureIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_nEFIjn-NK-0-removebg-preview 1.png';
String healthAndBeautyIcon =
    'assets/imgs_icons/sections/assets/imgs/unsplash_vKQeOUqrrOg-removebg-preview 1.png';

///more
String adCreatedIcon = 'assets/imgs_icons/sections/assets/icons/Group 297.svg';

String addCircleWhiteIcon =
    'assets/imgs_icons/more/assets/icons/add-circle.svg';
String addCircleBlackIcon =
    'assets/imgs_icons/more/assets/icons/add-circle-1.svg';
String addCircleGreenIcon =
    'assets/imgs_icons/more/assets/icons/add-circlelll.svg';
String myFavIcon = 'assets/imgs_icons/more/assets/icons/heart.svg';
String editWhiteIcon = 'assets/imgs_icons/more/assets/icons/jjjjjjjjjj.svg';
String editProfileIcon =
    'assets/imgs_icons/more/assets/icons/nenfduwefubfud.svg';
String logoutIcon = 'assets/imgs_icons/more/assets/icons/fffffff.svg';
String verifiedGreenIcon =
    'assets/imgs_icons/more/assets/icons/fluent_checkmark-starburst-16-filled.svg';
String takePhotoIcon = 'assets/imgs_icons/more/assets/icons/Frame.svg';
String techSupportIcon =
    'assets/imgs_icons/more/assets/icons/message-question.svg';
String changePassIcon = 'assets/imgs_icons/more/assets/icons/lock1.svg';
String whoAreWeIcon = 'assets/imgs_icons/more/assets/icons/info-circle.svg';
String privacyIcon = 'assets/imgs_icons/more/assets/icons/shield-tick.svg';
String deleteCollectionIcon =
    'assets/imgs_icons/more/assets/icons/h4elrfhnwekl.svg';
String fromGalleryIcon = 'assets/imgs_icons/more/assets/icons/jm.svg';
String emailBlackIcon = 'assets/imgs_icons/more/assets/icons/k.svg';
String emailWhiteIcon = 'assets/imgs_icons/more/assets/icons/k.svg';
String chatGreenIcon = 'assets/imgs_icons/more/assets/icons/message.svg';
String emptyFavIcon = 'assets/imgs_icons/more/assets/icons/Vector.svg';
String callBlackIcon = 'assets/imgs_icons/more/assets/icons/Vector-1.svg';
String verifiedWhiteIcon = 'assets/imgs_icons/more/assets/icons/Vector-2.svg';
String personIcon = 'assets/imgs_icons/more/assets/imgs/person.svg';
String editGreenIcon = 'assets/imgs_icons/more/assets/icons/edit-green.svg';
String viewIcon = 'assets/imgs_icons/more/assets/icons/eye.svg';
String reviewIcon = 'assets/imgs_icons/more/assets/icons/review.svg';
String changeProfilePicIcon =
    'assets/imgs_icons/home/assets/icons/cameraaaaa.svg';
