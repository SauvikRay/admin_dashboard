import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '/constants/app_constants.dart';
import '/constants/custome_theme.dart';
import '/helpers/all_routes.dart';
import '/helpers/dio/dio.dart';
import '/screens/home_screen.dart';
import '/screens/produtos_pen_icon_screen.dart';
import 'helpers/di.dart';
import 'helpers/helper.dart';
import 'helpers/navigation_service.dart';
import 'helpers/notification_service.dart';
import 'provider/catpopup_status.dart';
import 'provider/sub_category.dart';
import 'screens/categorias_screen.dart';
import 'screens/contacto_endereco_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/login_screen.dart';
import 'screens/lojas_screen.dart';
import 'screens/produtos_screen.dart';
import 'screens/ver_button_screen.dart';
import 'widgets/appbar_widget.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}
void main() async {
  diSetup();

  await GetStorage.init();
  DioSingleton.instance.create();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setId();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PopUpStatus>(
            create: ((context) => PopUpStatus())),
        ChangeNotifierProvider<SubCategory>(
          create: ((context) => SubCategory()),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const UtillScreenMobile();
          } else {
            return const UtillScreen();
          }
        },
      ),
    );
  }
}

class UtillScreen extends StatelessWidget {
  const UtillScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.mainTheme,
          builder: (context, widget) {
            // ScreenUtil.init(context);
            return MediaQuery(data: MediaQuery.of(context), child: widget!);
          },
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,

          home: const Loading(),
          //const VerButtonScreen(),
          //    ,

          //const ContactoEnderco(),
          //  const LojasScreen(),
          // const Categorias()

          // const Produtos(),
          // const ProdutosPenIcon(),
        );
      },
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.mainTheme,
          builder: (context, widget) {
            // ScreenUtil.init(context);
            return MediaQuery(data: MediaQuery.of(context), child: widget!);
          },
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,

          home: const Loading(),
          //const VerButtonScreen(),
          //    ,

          //const ContactoEnderco(),
          //  const LojasScreen(),
          // const Categorias()

          // const Produtos(),
          // const ProdutosPenIcon(),
        );
      },
    );
  }
}
