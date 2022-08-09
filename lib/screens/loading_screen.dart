import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '/helpers/dio/dio.dart';
import '/screens/home_screen.dart';
import '/screens/login_screen.dart';
import '/screens/lojas_screen.dart';
import '/screens/welcome_screen.dart';

import '../constants/app_constants.dart';
import '../helpers/navigation_service.dart';
import '../helpers/notification_service.dart';
import '../networks/api_acess.dart';
import 'categorias_screen.dart';
import 'contacto_endereco_screen.dart';
import 'order_detail.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  final appData = GetStorage();

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    appData.writeIfNull(kKeyIsLoggedIn, false);

    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);

      await getShopRXobj.fetchShopData();
      await getShopListRXobj.fetchShopListData();
      await getDashBoardRXobj.fetchFaqData();
      await getBalanceRecRXobj.fetchBalanceRecData();
      await getShopCategoryPopupListRXobj.fetchShopCategoryPopupListData();
//this should be called after shop api is called
      String restaurantId = appData.read(kKeyShopID) ?? '';
      if (restaurantId != '') {
        LocalNotificationService.getToken();
        await getDeliveyBoyRXobj.fetchGetDeliveyBoyData();
        await getShopDeliveyBoyRXobj.fetchGetShopDeliveyBoyData();
        await getProductCategoryRXobj.fetchProductCategoryData(restaurantId);
        await getShopHolidaysRXobj.fetchShopHolidaysData();
        await getOrderCountRXobj.fetchOrderCountData();
        await getItemListRXobj.fetchItemListData();
        await getShopHolidaysListApiRXobj.getShopHolidayListData();
        await getAllShopHolidaysRXobj.fetchAllShopHolidaysData();
        await getDashBoardOrderListRXobj.fetchDashBoardOrderListData();
        await getCustomerRangeRXobj.fetchCustomerRageData();
        await getOrderCountRXobj.fetchOrderCountData();
        await getItemListRXobj.fetchItemListData();
      }

      // await getProductShowRxobj.fetchProductShowData('293');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ConnectivityResult conStatus =
    //     Provider.of<ConnectivityProvider>(context).connectivityStatus;
    if (_isLoading) {
      return const WelcomeScreen();
      // } else if (conStatus == ConnectivityResult.none) {
      //   NavigationService.goBeBack;
      //   return const NoInternetScreen();
    } else {
      return appData.read(kKeyIsLoggedIn)
          ? const HomeScreen()
          // ? OrderDetail()
          //? const ContactoEnderco()
          : const LogeinScreen();
    }
  }
}
