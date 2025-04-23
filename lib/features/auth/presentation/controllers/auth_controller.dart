import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordHidden = true.obs;

  //  credentials from SharedPreferences 
  Future<bool> validateLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username') ?? 'admin';
    String? savedPassword = prefs.getString('password') ?? 'Pass@123';

    return username.value == savedUsername && password.value == savedPassword;
  }
}