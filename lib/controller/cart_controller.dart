import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client_dev_ja_vu/model/product/product.dart'; // Import your Product model
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var quantities = <String, int>{}.obs;
  var orders = <Map<String, dynamic>>[].obs;
  var serviceOptions = ''.obs;
  var status = 'In Preparation'; // Add status variable

  void addToCart(Product product) {
    final String productId = product.id ?? "default_id";
    if (quantities.containsKey(productId)) {
      quantities[productId] = quantities[productId]! + 1;
    } else {
      cartItems.add(product);
      quantities[productId] = 1;
    }
  }

  void removeFromCart(Product product) {
    final String productId = product.id ?? "default_id";
    if (quantities.containsKey(productId) && quantities[productId]! > 1) {
      quantities[productId] = quantities[productId]! - 1;
    } else {
      cartItems.remove(product);
      quantities.remove(productId);
    }
  }

  double get totalPrice => cartItems.fold(
        0,
        (sum, item) => sum + (item.price! * (quantities[item.id] ?? 1)),
      );

  Future<void> checkout(String customerId, String serviceOption, String address) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String dateTime = DateTime.now().toIso8601String();

      List<Map<String, dynamic>> productsData = cartItems.map((product) {
        return {
          'menu': product.name,
          'price': product.price,
          'quantity': quantities[product.id] ?? 1,
          'image': product.image, // Ensure 'image' property exists in Product model
        };
      }).toList();

      String username = GetStorage().read('loginUser')['name'] ?? 'No Username';
      dynamic phoneNumberDynamic = GetStorage().read('loginUser')['phoneNumber'];
      int phoneNumber = phoneNumberDynamic != null ? int.tryParse(phoneNumberDynamic.toString()) ?? 0 : 0;

      DocumentReference orderRef = await firestore.collection('orders').add({
        'customer': username,
        'phoneNumber': phoneNumber,
        'dateTime': dateTime,
        'products': productsData,
        'serviceOption': serviceOption,
        'totalPrice': totalPrice,
        'status': status, // Include status here
        if (serviceOption == 'Delivery') 'address': address,
      });

      String orderId = orderRef.id;

      orders.add({
        'orderId': orderId,
        'customer': username,
        'phoneNumber': phoneNumber,
        'dateTime': dateTime,
        'products': productsData,
        'serviceOption': serviceOption,
        'totalPrice': totalPrice,
        'status': status, // Also include status here
        if (serviceOption == 'Delivery') 'address': address,
      });

      cartItems.clear();
      quantities.clear();
      serviceOptions.value = '';

      Get.snackbar(
        'Success',
        'Order placed successfully',
        colorText: Colors.green,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey[300],
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order: $e',
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey[300],
      );
    }
  }
}
