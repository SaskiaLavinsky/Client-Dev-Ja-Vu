import 'package:client_dev_ja_vu/components/custom_button.dart';
import 'package:client_dev_ja_vu/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_dev_ja_vu/controller/cart_controller.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController cartController = Get.find();
  final TextEditingController serviceOptionsController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  String dropdownValue = 'Jenis Layanan'; // Default value for dropdown

  @override
  void dispose() {
    serviceOptionsController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

Future<bool> _showPaymentDialog() async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Pembayaran'),
        content: Container(
          constraints: BoxConstraints(maxWidth: 550), // Controlling maximum width
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  hintText: 'Nomor Kartu',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: expiryDateController,
                decoration: InputDecoration(
                  hintText: 'MM/YY',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),
              TextField(
                controller: cvcController,
                decoration: InputDecoration(
                  hintText: 'CVC',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Bayar'),
            onPressed: () {
              if (cardNumberController.text.isNotEmpty &&
                  expiryDateController.text.isNotEmpty &&
                  cvcController.text.isNotEmpty) {
                Navigator.of(context).pop(true);
              } else {
                Get.snackbar(
                  'Error',
                  'Silakan masukkan detail pembayaran',
                  colorText: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.white,
                );
              }
            },
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 148, 45, 38),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 30),
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartController.cartItems[index];
                return Container(
                  height: 123,
                  margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  decoration: CustomTheme.getCardDecoration(),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 12,
                            child: SizedBox(
                              height: double.infinity,
                              child: Image.network(
                                product.image ?? '',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      product.name ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Beau Rivage',
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartController.removeFromCart(product);
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                        Obx(() => Text(
                                          "Qty: ${cartController.quantities[product.id] ?? 1}",
                                          style: Theme.of(context).textTheme.bodySmall,
                                        )),
                                        IconButton(
                                          onPressed: () {
                                            cartController.addToCart(product);
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Obx(() => Text(
                                      "Rp ${product.price! * (cartController.quantities[product.id] ?? 1)}",
                                      style: TextStyle(
                                        fontFamily: 'Alegreya',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
          priceFooter(cartController),
          Obx(() {
            if (cartController.cartItems.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward, color: Colors.white, size: 30),
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      dropdownColor: Color.fromARGB(255, 157, 88, 88),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Jenis Layanan', 'Dine-in', 'Take-away', 'Delivery']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  if (dropdownValue == 'Delivery')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextField(
                        controller: serviceOptionsController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          labelText: 'Masukkan alamat untuk pengiriman',
                          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                          fillColor: Colors.white10,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: CustomButton(
                      text: "PESAN",
                      onPress: () async {
                        if (dropdownValue == 'Jenis Layanan') {
                          Get.snackbar(
                            'Error',
                            'Silakan pilih jenis layanan terlebih dahulu',
                            colorText: Colors.red,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.white,
                          );
                        } else if (dropdownValue == 'Delivery' && serviceOptionsController.text.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Silakan isi alamat untuk pengiriman',
                            colorText: Colors.red,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.white,
                          );
                        } else {
                          bool paymentSuccessful = await _showPaymentDialog();
                          if (paymentSuccessful) {
                            String selectedServiceOption = dropdownValue;
                            String addressForDelivery = dropdownValue == 'Delivery' ? serviceOptionsController.text : '';
                            cartController.checkout('username', selectedServiceOption, addressForDelivery);
                          }
                        }
                      },
                      loading: false,
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget priceFooter(CartController cartController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 2,
            color: CustomTheme.grey,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    fontFamily: 'Alegreya',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Obx(() => Text(
                  "Rp ${cartController.totalPrice}",
                  style: TextStyle(
                    fontFamily: 'Alegreya',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
