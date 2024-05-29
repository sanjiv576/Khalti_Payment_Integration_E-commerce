import '../../view/cart_view.dart';
import '../../view/home_view.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/';
  static const String cartRoute = '/cart';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      cartRoute: (context) => const CartView(),
    };
  }
}
