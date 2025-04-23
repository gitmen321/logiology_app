import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var profileImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
  }

  // Load saved data from SharedPreferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'admin';
    password.value = prefs.getString('password') ?? 'Pass@123';
    profileImagePath.value = prefs.getString('profileImagePath') ?? '';
  }

  // Save profile data to SharedPreferences
  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username.value);
    await prefs.setString('password', password.value);
    await prefs.setString('profileImagePath', profileImagePath.value);
  }

  //  username updt
  void updateUsername(String newUsername) async {
    username.value = newUsername;
    await _saveProfileData();
    Get.snackbar('Success', 'Username updated');
  }

  //  password updt
  void updatePassword(String newPassword) async {
    password.value = newPassword;
    await _saveProfileData();
    Get.snackbar('Success', 'Password updated');
  }

  // Image picking from camera/gallry
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      profileImagePath.value = image.path;
      await _saveProfileData();
      Get.snackbar('Success', 'Profile picture updated');
    }
  }

  // Confirm password before navigating to change-password page
  void confirmPasswordAndNavigate(String enteredPassword) {
    if (enteredPassword == password.value) {
      Get.back(); // Close dialog
      Get.toNamed('/change-password');
    } else {
      Get.snackbar('Error', 'Incorrect password');
    }
  }

  //  password confirmation dialogg
  void showPasswordConfirmationDialog() {
    final TextEditingController passController = TextEditingController();

    Get.defaultDialog(
      title: 'Confirm Password',
      content: Column(
        children: [
          TextField(
            controller: passController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Enter your password',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      textConfirm: 'Confirm',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        confirmPasswordAndNavigate(passController.text.trim());
      },
      onCancel: () => Get.back(),
    );
  }
}
