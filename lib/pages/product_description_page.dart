import 'package:client_dev_ja_vu/model/product/product.dart';
import 'package:client_dev_ja_vu/pages/Utama.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_dev_ja_vu/controller/cart_controller.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    Product product = Get.arguments['data'];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.network(
                      product.image ?? '', // URL gambar
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 30),
                    child: Text(
                      product.name ?? '',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Beau Rivage"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Rp: ${product.price ?? ''}',
                          style: TextStyle(
                            fontFamily: 'Alegreya',
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        cartController.addToCart(product);
                        Get.snackbar(
                          'Success', 
                          'Product added to cart successfully', 
                          colorText: Colors.green,
                          snackPosition: SnackPosition.TOP,
                          duration: Duration(seconds: 2), backgroundColor: Colors.grey[300]
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 182, 133, 93),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                      ),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      "About this Menu",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Beau Rivage"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      product.description ?? '',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 25,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 182, 133, 93),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Utama()),
                    );
                  },
                ),
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
