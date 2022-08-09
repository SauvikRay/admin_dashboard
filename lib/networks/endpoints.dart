// ignore_for_file: constant_identifier_names
//live url
// const String url = "https://wedeapp.eu";
//test test
//const String url = "";
//staging
const String url = "https://wedeli-shop.dev.squaredbyte.com";

class NetworkConstants {
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZWJ1eS1hbmRyb2lkLWFwcHMiLCJpYXQiOjE1NzIzNzI3Nzh9.X1qxpv6WDUP-7Ootx7cISwCUeYtulHhqhxvDjpAzCSg";
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

class Endpoints {
  static String postlogin() => "/api/login";
  static String getLogout() => "/api/logout";
  static String getDashBoard() => "/api/shop-dashboard";
  static String getShop() => "/api/shop-show";
  static String getShopList() => "/api/shop-list";
  static String getDeliveryBoyList() => "/api/delivery-men";
  static String getShopDeliveryBoyList() => "/api/shop-delivery-men";
  static String postShopDeliveryBoyList() => "/api/assign-shop-delivery-men";
  static String postShopAddress(String shop) => "/api/save-shop-contact/$shop";
  static String postShopSchedule() => "/api/save-shop-schedule";
  static String getShopSchedule(String shop) => "/api/shop-schedule/$shop";
  static String postShopHolidays() => "/api/save-shop-holiday";
  static String postShopHolidaysDelete() => "/api/delete-shop-holiday";
  static String deleteShop(String shop) => "/api/shop-delete/$shop";
  static String getAllShopHolidaysList(String shop) =>
      "/api/shop-holiday-list/$shop";
  static String getShopHolidaysList(String shop,
          {int record = 10, int page = 1}) =>
      "/api/shop-holidays/$shop?number=$record&page=$page";
  static String getOrders(String status, {int record = 10, int page = 1}) =>
      "/api/order-list/$status?number=$record&page=$page";
  static String getBalanceRecord(String shop,
          {int record = 10, int page = 1}) =>
      "/api/shop-balance-record/$shop?number=$record&page=$page";
  static String getItemList(String shop, {int record = 10, int page = 1}) =>
      "/api/shop-product/$shop?number=$record&page=$page";
  static String postProductCategory() => "/api/shop-product-category-save";
  static String postOrderStatus() => "/api/order/order-status";
  static String getOrderDetails(String orderID) => "/api/orders/$orderID";
  static String getProductCategory(String restaurantId) =>
      "/api/shop-product-category/$restaurantId";
  static String postProductCategorySave() => "/api/shop-product-category-save";
  static String getShopCategory() => "/api/shop-categories";
  static String getShopSubCategoryPopUpList(String categoriesId) =>
      "/api/shop-subcategories/$categoriesId";
  static String updateShopCategory() => "/api/shop-product-category-save";
  static String deleteProductCategory(String productCatID) =>
      "/api/shop-product-category-delete/$productCatID";
  static String getOrderCount() => "/api/shop-order-count";
  static String postSaveShopBasic() => "/api/save-shop-basic";
  static String getCustomerRange() => "/api/shop-customer-range";
  static String postShopCustomerRange(String shop) =>
      "/api/save-shop-customer-range/$shop";
  static String postProductBasic() => "/api/save-product-basic";
  static String postProductPriching() => "/api/save-product-pricing";
  static String postProductAddonSave() => "/api/product-addon-save";
  static String postShowProductAddon(String foodId,
          {int record = 10, int page = 1}) =>
      "/api/product-addon-list/$foodId?number=$record&page=$page";
  static String deleteProductAddon(String addonId) =>
      "/api/shop-addon-delete/$addonId";
  static String getShowShopProduct(String foodId) =>
      "/api/show-shop-product/$foodId";

  static String getDashBoardOrderList({int record = 10, int page = 1}) =>
      "/api/shop-dashboard-order-list/?number=$record&page=$page";
  static String postDeviceToken() => "/api/device-token";
  static String deleteProductOptionPrice() => "/api/delete-product-pricing";
  // ?bill_type=$billtype&name=$name&email=$email&phone=$phone&message=$message&documents=$file"

  // static String signup() => "/services/app/MobileAppCommon/CustomerRegister";

  // static String verification() =>
  //     "$url" + "/services/app/MobileAppCommon/VerifyPhoneNumber";

  // static String resendVerification(String email) =>
  //     "$url" +
  //     "/services/app/MobileAppCommon/ResendPhoneVerificationCode?email=$email";

  // static String signin() => "/TokenAuth/AuthenticateForApp";

  // static String socialSignin(
  //   String fNmae,
  //   String lName,
  //   String email,
  //   String provider,
  //   String providerKey,
  // ) =>
  //     "$url" +
  //     "/TokenAuth/ExternalAuthenticateForApp?FirstName=$fNmae&LastName=$lName&Email=$email&Provider=$provider&ProviderKey=$providerKey";

  // static String sendPasswordResetCode() =>
  //     "/services/app/MobileAppCommon/SendPasswordResetCode";

  // static String verifyPasswordResetCode() =>
  //     "$url" + "/services/app/MobileAppCommon/VerifyPasswordResetCode";

  // static String resetPassword() =>
  //     "$url" + "/services/app/MobileAppCommon/ResetPassword";

  // static String topProductCategoriesByHub(String id) =>
  //     "/services/app/MobileAppCommon/GetTopProductCategoriesByHub?hubid=$id";
  // //requires shop id
  // static String productsByCategory(String id) =>
  //     "/services/app/MobileAppCommon/GetAllProductByCategory?productCategoryId=$id";

  // static String topStoresByHub(String id) =>
  //     "/services/app/MobileAppCommon/GetTopStoresByHub?hubid=$id";

  // static String getAllStoresByHub(String id) =>
  //     "/services/app/MobileAppCommon/GetAllStoresByHub?hubid=$id";

  // static String topRatedProductsByHub(String id) =>
  //     "/services/app/MobileAppCommon/GetTopProductsByHub?hubid=$id";

  // static String currentUserInformation() =>
  //     "$url" + "/services/app/Session/GetCurrentLoginInformations";

  // static String paymentTestSquare() =>
  //     "https://connect.squareupsandbox.com/v2/payments";

  // static String placeOrder() => "/services/app/MobileAppCommon/CreateOrder";

  // static String viewOrders(int contactId) =>
  //     "/services/app/MobileAppCommon/GetAllOrdersByContact?contactId=$contactId";

  // static String getAllStore() =>
  //     "$url" + "/services/app/MobileAppCommon/GetAllCustomStore";

  // static String cancelOrder(int orderId) =>
  //     "/services/app/MobileAppCommon/CancelOrder?orderId=$orderId";

  // static String editProfile() =>
  //     "$hubURL" + "/api/services/app/MobileAppCommon/EditProfile";

  // static String getHubLocations() =>
  //     "$hubURL" + "/api/services/app/PublicPagesCommon/GetAllHubForDropdown";

  // static String getAllProductCategoriesByStore(String id) =>
  //     "/services/app/MobileAppCommon/GetAllProductCategoriesByStore?storeid=$id";

  // static String getAllProductsByStoreAndCategory(
  //         String storeId, String categoryId) =>
  //     "/services/app/MobileAppCommon/GetAllProductsByStoreAndCategory?storeid=$storeId&productcategoryId=$categoryId";

  // static String sendBulkContactForReferral() =>
  //     "$hubURL" +
  //     "/api/services/app/MobileAppCommon/SaveBulkContactForReferral";

  // static String getProductDetailsById(String productId) =>
  //     "$hubURL" +
  //     "/services/app/PublicPagesCommon/GetProductDetailsById?productId=$productId";

  // static String getAllProductReviewsByProduct(String productId) =>
  //     "$hubURL" +
  //     "/services/app/PublicPagesCommon/GetAllProductReviewsByProductBySp?ProductIdFilter=$productId&IsPublish=1";

  // static String addContactAddresses(String productId) =>
  //     "$hubURL" + "/services/app/ContactAddresses/CreateOrEdit";

  // static String getContactAddresses(int contactId) =>
  //     "$hubURL" +
  //     "/api/services/app/ContactAddresses/GetAllByContactId?contactId=$contactId";
}
