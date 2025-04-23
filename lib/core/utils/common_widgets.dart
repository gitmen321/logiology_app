 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logiology_app/app/routes/app_routes.dart';
import 'package:logiology_app/features/products/presentation/controllers/product_controller.dart';

Widget buildListTile({
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

  void confirmLogout(BuildContext context) {
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


void showFilterDialog(BuildContext context, ProductController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Filter Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text("Category", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: controller.selectedCategory.value.isEmpty
                    ? null
                    : controller.selectedCategory.value,
                decoration: _dropdownDecoration(),
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                hint: const Text('Select Category',
                    style: TextStyle(color: Colors.white54)),
                items: [
                  'smartphones',
                  'laptops',
                  'fragrances',
                  'skincare',
                  'groceries',
                  'home-decoration'
                ]
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedCategory.value = value ?? '';
                  controller.filterProducts();
                },
              ),
              const SizedBox(height: 16),
              Text("Tag", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: controller.selectedTag.value.isEmpty
                    ? null
                    : controller.selectedTag.value,
                decoration: _dropdownDecoration(),
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                hint: const Text('Select Tag',
                    style: TextStyle(color: Colors.white54)),
                items: ['new', 'sale', 'popular']
                    .map((tag) => DropdownMenuItem(
                          value: tag,
                          child: Text(tag),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedTag.value = value ?? '';
                  controller.filterProducts();
                },
              ),
              const SizedBox(height: 16),
              Obx(() => Text(
                "Max Price: \$${controller.maxPrice.value.toInt()}",
                style: TextStyle(color: Colors.white70),
              )),
              Slider(
                value: controller.maxPrice.value,
                min: 0,
                max: 1000,
                divisions: 100,
                activeColor: Colors.teal,
                inactiveColor: Colors.white24,
                label: '\$${controller.maxPrice.value.round()}',
                onChanged: (value) {
                  controller.maxPrice.value = value;
                  controller.filterProducts();
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.resetFilters();
              Get.back();
            },
            child: Text(
              'Reset',
              style: GoogleFonts.lato(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 62, 126),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Apply',
              style: GoogleFonts.lato(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}

InputDecoration _dropdownDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white10,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}