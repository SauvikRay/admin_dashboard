import 'dart:io';
import 'package:flutter/cupertino.dart';
import '/screens/categorias_screen.dart';
import '/screens/loading_screen.dart';
import '/screens/order_detail.dart';
import '../screens/contacto_endereco_screen.dart';
import '../screens/home_screen.dart';
import '../screens/lojas_screen.dart';
import '../screens/produtos_pen_icon_screen.dart';
import '../screens/produtos_screen.dart';
import '../screens/todas_as_categories_screen.dart';
import '../screens/ver_button_screen.dart';

class Routes {
  //static const String loader='/loader';
  static const String home = '/home';
  static const String verButton = '/verButton';
  static const String lojas = '/lojas';
  static const String categories = '/categories';
  static const String produtos = '/produtos';
  static const String contactoEnderco = '/contactoEnderco';
  static const String produtosPenIcon = '/produtosPenIcon';
  static const String todasAsCategories = '/todasAsCategories';
  static const String loadingScreen = '/loadingScreen';
  static const String orderDetailScreen = '/orderDetailScreen';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const HomeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const HomeScreen());
      case Routes.verButton:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const VerButtonScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const VerButtonScreen());
      case Routes.lojas:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LojasScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const LojasScreen());
      case Routes.categories:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const Categorias(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const Categorias());
      case Routes.produtos:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const Produtos(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const Produtos());
      case Routes.contactoEnderco:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ContactoEnderco(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const ContactoEnderco());
      case Routes.produtosPenIcon:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProdutosPenIcon(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const ProdutosPenIcon());
      case Routes.todasAsCategories:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const TodasAsCategories(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const TodasAsCategories());
      case Routes.loadingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const Loading(),
                settings:
                    settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
            : CupertinoPageRoute(builder: (context) => const Loading());
      case Routes.orderDetailScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const OrderDetail(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const OrderDetail());
      // case Routes.navigation:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const NavigationScreen(),
      //           settings:
      //               settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
      //       : CupertinoPageRoute(
      //           builder: (context) => const NavigationScreen());

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(microseconds: 100),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}
