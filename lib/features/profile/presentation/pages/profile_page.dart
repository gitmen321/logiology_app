import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology_app/app/routes/app_routes.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';
// import '../../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(title:  Text('My Profile', style: GoogleFonts.lato(color: Colors.white, fontSize: 20),)),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: controller.profileImagePath.value.isNotEmpty
                            ? FileImage(File(controller.profileImagePath.value))
                            : null,
                        child: controller.profileImagePath.value.isEmpty
                            ? const Icon(Icons.person, size: 55)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Choose Image Source'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      controller.pickImage(ImageSource.camera);
                                      Get.back();
                                    },
                                    child: const Text('Camera'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.pickImage(ImageSource.gallery);
                                      Get.back();
                                    },
                                    child: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blueAccent,
                            child: Icon(Icons.edit, color: Colors.white, size: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // List Tiles
                _buildListTile(
                  icon: Icons.lock_reset,
                  title: 'Change Username & Password',
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                ),
                _buildListTile(
                  icon: Icons.card_giftcard,
                  title: 'Refer & Earn',
                  onTap: () => Get.snackbar("Coming Soon", "Referral system is in progress 🚀"),
                ),
                _buildListTile(
                  icon: Icons.support_agent,
                  title: 'Contact Us',
                  onTap: () => Get.snackbar("Contact Us", "Email: support@logiology.com"),
                ),

                const SizedBox(height: 24),

                // Logout Button
                ElevatedButton.icon(
                  onPressed: () => _confirmLogout(context),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Logout Confirmation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
