class AppConstants {
  AppConstants(){}
  static String apiUrl({required int limit, required int skip}) {
    return 'https://dummyjson.com/products?limit=$limit&skip=$skip';
  }
  static const appLogo = 'assets/logo/logiologylogo.png';
}