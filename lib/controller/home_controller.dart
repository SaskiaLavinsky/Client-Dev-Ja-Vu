import 'package:client_dev_ja_vu/model/product/product.dart';
import 'package:client_dev_ja_vu/model/product_category/product_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> productShowInUi = [];
  List<ProductCategory> productCategories = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs.map((doc) =>
        Product.fromJson(doc.data() as Map<String, dynamic>)
      ).toList();
      products.clear();
      products.assignAll(retrievedProducts);
      // Set productShowInUi to all products initially
      productShowInUi.clear();
      productShowInUi.assignAll(products);
      Get.snackbar('Success', 'Products fetched successfully', colorText: Colors.green, backgroundColor: Colors.grey[300],);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red, backgroundColor: Colors.grey[300]);
      print(e);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs.map((doc) =>
        ProductCategory.fromJson(doc.data() as Map<String, dynamic>)
      ).toList();
      productCategories.clear();
      productCategories.assignAll(retrievedCategories);
      
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red, backgroundColor: Colors.grey[300]);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
  if (category == 'Semua') {
    productShowInUi.assignAll(products); // Menampilkan semua produk jika dipilih "All"
  } else {
    productShowInUi = products.where((product) => product.category == category).toList();
  }
    update(); // Memperbarui tampilan setelah filter diterapkan
  }

  filterByFrom(List<String> froms) {
  if (froms.isEmpty) {
    productShowInUi = List<Product>.from(products); // Menggunakan List.from untuk menyalin List<Product>
  } else {
    List<String> lowerCaseFroms = froms.map((from) => from.toLowerCase()).toList();
    productShowInUi = products.where((product) => lowerCaseFroms.contains(product.from?.toLowerCase() ?? '')).toList();
  }
  update(); // Memperbarui tampilan setelah filter diterapkan
}

  sortByPrice({required bool ascending}){
    List<Product> sortedProducts = List<Product>.from(productShowInUi);
    sortedProducts.sort((a, b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    productShowInUi = sortedProducts;
    update();
  }

}
