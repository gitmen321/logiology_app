import 'package:get/get.dart';
import 'package:logiology_app/features/auth/presentation/pages/login_page.dart';
import 'package:logiology_app/features/products/presentation/pages/home_page.dart';
import 'package:logiology_app/features/products/presentation/pages/product_detail_page.dart';
import 'package:logiology_app/features/profile/presentation/pages/change_password_page.dart';
import 'package:logiology_app/features/profile/presentation/pages/profile_page.dart';
// import '../features/auth/presentation/pages/login_page.dart';
// import '../features/products/presentation/pages/home_page.dart';
// import '../features/products/presentation/pages/product_detail_page.dart';
// import '../features/profile/presentation/pages/profile_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetail = '/product_detail';
  static const String profile = '/profile';
  static const String changePassword = '/change_password';


  static final routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: productDetail, page: () => const ProductDetailPage()),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: changePassword, page: ()=> ChangePasswordPage()),
  ];
}