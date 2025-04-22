// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logiology_app/app/routes/app_routes.dart';
// import 'package:logiology_app/core/themes/app_theme.dart';
import '../controllers/product_controller.dart';
// import '../../../app/routes/app_routes.dart';
// import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 9, 14),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ClipRRect(
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/logo/logiologylogo.png'), // 👈 make sure this path matches your asset
              radius: 20,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 9, 14),
        title: Text('Logiology', style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () => Get.toNamed(AppRoutes.profile),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.products.isEmpty) {
          return Center(
            child: SizedBox(
              width: 150, // or MediaQuery.of(context).size.width * 0.8
              child: LinearProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.white24,
                minHeight: 4,
              ),
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search Products',
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  controller.searchQuery.value = value;
                  controller.filterProducts();
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => _showFilterDialog(context, controller),
                      icon: Icon(
                        Icons.tune_rounded,
                        color: Colors.white,
                      )),
                  Text(
                    'Filter',
                    style: TextTheme.of(context).bodyMedium,
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.productDetail, arguments: product);
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: Colors.white.withOpacity(0.05),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize
                                  .min, // Ensures Column shrinks to fit content
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product.thumbnail,
                                    height: constraints.maxWidth > 200
                                        ? 120
                                        : 100, // adjusts height based on screen
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 18),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${product.rating}',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (controller.isLoading.value)
              Center(
                child: SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.white24,
                    minHeight: 4,
                  ),
                ),
              ),
            IconButton(
                onPressed: () => controller.fetchProducts(isLoadMore: true),
                icon: Icon(
                  Icons.arrow_downward_sharp,
                  color: Colors.white,
                ))
          ],
        );
      }),
    );
  }

  void _showFilterDialog(BuildContext context, ProductController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  items: ['electronics', 'clothing', 'jewelry', 'Perfumes']
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
                const SizedBox(height: 24),
                Text("Max Price: \$${controller.maxPrice.value.toInt()}",
                    style: TextStyle(color: Colors.white70)),
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
}
