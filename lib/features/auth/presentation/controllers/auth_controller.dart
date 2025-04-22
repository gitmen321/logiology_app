import 'package:get/get.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
    var isPasswordHidden = true.obs;


  bool validateLogin() {
    return username.value == 'admin' && password.value == 'Pass@123';
  }
}