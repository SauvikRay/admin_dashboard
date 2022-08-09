class AppRegFormText {
  // static const String regName = 'Nome completo';
  // static const String regEmail = 'nome@example.com';
  // static const String phoneNumber = 'Phone Number';
  // static const String palavraPasse = 'Palavra Passe';
}

class ButtonText {
  static const String registar = 'Registar';
  static const String login = 'Login';
}

class AssetIcons {
  //Images
  // static const String splash = 'assets/images/splash.png';

  //Icons
  static const String shop = 'assets/icons/shop.svg';
  static const String seetings = 'assets/icons/seeting.svg';
  static const String splash = 'assets/icons/splash.svg';
  static const String splashPg = 'assets/icons/splashpng.png';
  static const String edit = 'assets/icons/edit.svg';
  static const String minus = 'assets/icons/minus.svg';
  static const String add = 'assets/icons/add.svg';
  static const String arrowForward = 'assets/icons/arrow_forward.svg';
  static const String balance = 'assets/icons/balance.svg';
  static const String orderslist = 'assets/icons/orderslist.svg';
  static const String sates = 'assets/icons/setas.svg';
  static const String buttonPlusIcon = 'assets/icons/buttonPlusIcon.svg';
  static const String imagePlaceHolder = 'assets/icons/placeHolder.png';
  static const String man = 'assets/icons/man.svg';
  static const String password = 'assets/icons/password.svg';
  static const String box = 'assets/icons/box.svg';
  static const String i = 'assets/icons/i.svg';
  static const String reload = 'assets/icons/reload.svg';
  static const String dashBox = 'assets/icons/dashbox.svg';
  static const String deliveryman = 'assets/icons/deliveryman.png';
  static const String line = 'assets/icons/line.svg';
  static const String shortLine = 'assets/icons/shortLine.svg';
}

class OrderStatusNo {
  static const String kPENDING = '0'; //order just placed
  static const String kACCEPTED = '10'; //after accepted by shop owner
  static const String kFOODPROCESSING = '20';
  static const String kFOODREADY = '21';
  static const String kFOODPICKED = '30';
  static const String kFOODDELIVERED = '40';
  static const String kCANCELLED = '80';
  static const String kREJECTEDBYSHOP = '90';
  static const String kFAILED = '100';
  static const String kALL = 'all';
}

class DeliveryStatusNo {
  static const String kPENDIG = '0';
  static const String kDELIVERYMANCONFIRMED = '10';
  static const String kDELIVERYSTARTED = '11';
  static const String kARRIVEDATSHOP = '20';
  static const String kONTRANSIT = '30';
  static const String kDELIVERED = '40';
}

const String kImageUrl = 'imageUrl';
// Keys
const String kKeyStatus = 'status';
const String kKeyJsonObject = 'json_object';
const String kKeyJsonArray = 'json_array';
const String kKeyStringData = 'string_data';
const String kKeyMessage = 'message';
const String kKeyData = 'data';
const String kKeyCode = 'code';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kPhone = 'phone_number';
const String kKeySelectedLocation = 'selected_location';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'language_code';
const String kKeyName = 'name';
const String kKeyToken = 'token';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';
const String kKeyUser = 'user';
const String kKeyEmailVerifiedAt = 'email_verified_at';
const String kKeyPhoneVerifiedAt = 'phone_verified_at';
const String kKeyFaqText = 'faq_text';
const String kKeyTermsAndConditionsText = 'toc_text';
const String kKeyAverageRating = 'average_rating';
const String kKeyViews = 'views';
const String kKeyProvider = 'provider';
const String kFacebook = 'facebook';
const String kApple = 'apple';
const String kGoogle = 'google';
const String kKeyEnglish = 'en';
const String kKeyPortuguese = 'pt';
const String kKeyFrench = 'fr';
const String kKeyGerman = 'de';
const String kKeySpanish = 'es';
const String kKeyFirstName = 'first_name';
const String kKeyLastName = 'lst_name';
const String kKeyDeviceID = 'device_id';
const String kKeyUserID = 'user_id';
const String kKeyShopID = 'shop_id';
const String kKeycategoriesID = 'categoriesId';
const String kKeyproductID = 'productId';
const String kKeyShopSlug = 'shop_slug';
//order statuses

const List<String> kLanguagesKey = [
  kKeyEnglish,
  kKeyPortuguese,
  kKeyFrench,
  kKeyGerman,
  kKeySpanish
];
const Map languages = <String, String>{
  kKeyEnglish: "English",
  kKeyPortuguese: "Portuguese",
  kKeyFrench: "French",
  kKeyGerman: "German",
  kKeySpanish: "Spanish",
};
const Map countriesCode = <String, String>{
  kKeyEnglish: "US",
  kKeyPortuguese: "PT",
  kKeyFrench: "FR",
  kKeyGerman: "DE",
  kKeySpanish: "ES",
};
