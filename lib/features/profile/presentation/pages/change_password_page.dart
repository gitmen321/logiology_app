import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology_app/features/profile/presentation/controllers/profile_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final TextEditingController newPassController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.back(),
         icon: Icon(Icons.arrow_back_ios_new)),
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter new password:'),
            const SizedBox(height: 8),
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Confirm new password:'),
            const SizedBox(height: 8),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final newPass = newPassController.text.trim();
                  final confirmPass = confirmPassController.text.trim();

                  if (newPass.isEmpty || confirmPass.isEmpty) {
                    Get.snackbar('Error', 'Fields cannot be empty');
                    return;
                  }

                  if (newPass != confirmPass) {
                    Get.snackbar('Error', 'Passwords do not match');
                    return;
                  }

                  controller.updatePassword(newPass);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  'Update Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
