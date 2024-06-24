import 'package:client_dev_ja_vu/pages/cart.dart';
import 'package:client_dev_ja_vu/pages/home_page.dart';
import 'package:client_dev_ja_vu/pages/listPesanan.dart';
import 'package:client_dev_ja_vu/pages/profile.dart';
import 'package:client_dev_ja_vu/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_dev_ja_vu/controller/cart_controller.dart';

class Utama extends StatefulWidget {
  const Utama({super.key});

  @override
  State<Utama> createState() => _UtamaState();
}

class _UtamaState extends State<Utama> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi CartController
    Get.put(CartController());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 148, 45, 38),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0), // Set this to your desired height
        child: AppBar(
          automaticallyImplyLeading: false, // This removes the back button
          backgroundColor: const Color.fromARGB(255, 196, 195, 195),
          elevation: 0,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24),
                  Image.asset(
                    'img/devjavu-removebg.png',
                    fit: BoxFit.contain,
                    height: 80,
                  ),
                  const SizedBox(width: 24),
                  const Text(
                    "Dev Ja Vu",
                    style: TextStyle(
                      fontFamily: 'Beau Rivage',
                      fontSize: 45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  // Menggunakan Container dengan alignment untuk mengatur posisi vertikal
                  Container(
                    alignment: Alignment.center,
                    height: kToolbarHeight, // Tinggi Container sama dengan tinggi AppBar
                    child: IconButton(
                      icon: Icon(Icons.list_alt, size: 35),
                      onPressed: () {
                        Get.to(() => ListPesanan());
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 196, 195, 195),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          boxShadow: CustomTheme.cardShadow,
        ),
        child: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(vertical: 5),
          indicatorColor: Colors.transparent,
          labelColor: Color.fromARGB(255, 148, 45, 38),
          unselectedLabelColor: const Color.fromARGB(255, 60, 60, 60),
          tabs: const [
            Tab(icon: Icon(Icons.home,
          size: 30,)),
            Tab(icon: Icon(Icons.shopping_cart,
          size: 30,)),
            Tab(icon: Icon(Icons.person,
          size: 30,)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomePage(),
          Cart(),
          Profile(),
        ],
      ),
    );
  }
}
