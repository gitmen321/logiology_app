import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logiology_app/app/routes/app_routes.dart';
import 'package:logiology_app/core/constants/app_constants.dart';
import 'package:logiology_app/core/utils/common_widgets.dart';
import 'package:logiology_app/core/utils/custom_loader.dart';
import 'package:logiology_app/features/products/presentation/controllers/product_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 9, 14),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: ClipRRect(
            child: CircleAvatar(
              backgroundImage: AssetImage(AppConstants.appLogo),
              radius: 10,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 9, 14),
        title: Text('Logiology',
            style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
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
          return SizedBox.expand(
            child: Center(
              child: SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLoader(),
                    SizedBox(height: 8,),
                    Text(
                      'Explore our products',
                      style:
                          GoogleFonts.lato(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
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
                      onPressed: () => showFilterDialog(context, controller),
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
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product.thumbnail,
                                    height:
                                        constraints.maxWidth > 200 ? 120 : 100,
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
                    child: CustomLoader(
                      size: 20,
                    )),
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
}
