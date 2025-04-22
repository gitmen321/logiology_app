import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository = ProductRepository();
  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var isLoading = false.obs;
  var page = 0.obs;
  var selectedCategory = ''.obs;
  var selectedTag = ''.obs;
  var maxPrice = 1000.0.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts({bool isLoadMore = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final newProducts = await repository.fetchProducts(
        skip: isLoadMore ? page.value * 10 : 0,
        limit: 10,
      );
      if (isLoadMore) {
        products.addAll(newProducts);
      } else {
        products.assignAll(newProducts);
      }
      filteredProducts.assignAll(products);
      if (isLoadMore) page.value++;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void filterProducts() {
    filteredProducts.assignAll(products.where((product) {
      final matchesCategory = selectedCategory.value.isEmpty ||
          product.category == selectedCategory.value;
      final matchesTag =
          selectedTag.value.isEmpty || product.tags.contains(selectedTag.value);
      final matchesPrice = product.price <= maxPrice.value;
      final matchesSearch = searchQuery.value.isEmpty ||
          product.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesTag && matchesPrice && matchesSearch;
    }).toList());
  }

  void resetFilters() {
    selectedCategory.value = '';
    selectedTag.value = '';
    maxPrice.value = 1000.0;
    searchQuery.value = '';
    filterProducts();
  }
}