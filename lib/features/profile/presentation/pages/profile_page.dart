import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology_app/app/routes/app_routes.dart';
import 'package:logiology_app/core/utils/common_widgets.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.back(),
         icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          'My Profile',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
        ),
        
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: controller
                                .profileImagePath.value.isNotEmpty
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
                            child:
                                Icon(Icons.edit, color: Colors.white, size: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // List Tiles
                buildListTile(
                  icon: Icons.lock_reset,
                  title: 'Change Username & Password',
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                ),
                buildListTile(
                  icon: Icons.card_giftcard,
                  title: 'Refer & Earn',
                  onTap: () => Get.snackbar(
                      "Coming Soon", "Referral system is in progress 🚀"),
                ),
                buildListTile(
                  icon: Icons.support_agent,
                  title: 'Contact Us',
                  onTap: () =>
                      Get.snackbar("Contact Us", "Email: abcd@logiology.com"),
                ),

                const SizedBox(height: 24),

                ElevatedButton.icon(
                  onPressed: () => confirmLogout(context),
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
