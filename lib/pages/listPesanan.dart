import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_dev_ja_vu/controller/cart_controller.dart';

class ListPesanan extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 196, 195, 195),
          elevation: 0,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daftar Pesanan',
                          style: TextStyle(
                            fontFamily: 'Beau Rivage',
                            fontSize: 45,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 148, 45, 38),
        child: Obx(() => ListView.builder(
              itemCount: cartController.orders.length,
              itemBuilder: (context, index) {
                final order = cartController.orders[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        // Display order details
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: order['products'].length,
                          itemBuilder: (ctx, idx) {
                            final product = order['products'][idx];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: product['image'] != null
                                      ? Image.network(
                                          product['image'],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.image_not_supported,
                                          size: 60),
                                  title: Text(
                                    product['menu'] ?? '',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Beau Rivage"),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Harga satuan menu: Rp ${product['price'] ?? 0}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Alegreya"),
                                      ),
                                      Text(
                                        'Qty: ${product['quantity'] ?? 1}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Alegreya"),
                                      ),
                                      Text(
                                        'Harga total: Rp ${(product['quantity'] ?? 1) * (product['price'] ?? 0)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Alegreya"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Total Harga: Rp ${order['totalPrice'] ?? 0}',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Alegreya"),
                          ),
                        ),
                        Text(
                          'Service Option: ${order['serviceOption'] ?? 'N/A'}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Alegreya"),
                        ),
                        if (order['serviceOption'] == 'Delivery')
                          Text(
                            'Alamat: ${order['address'] ?? 'N/A'}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Alegreya"),
                          ),
                        SizedBox(height: 5),
                        Text(
                          'Waktu Pesanan: ${order['dateTime'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        // Status
                        SizedBox(height: 5),
                        Text(
                          'Status: ${order['status'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
