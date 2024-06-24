import 'package:client_dev_ja_vu/user_auth/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: w,
            height: h,
            color: Color.fromARGB(255, 148, 45, 38), // Warna latar belakang
          ),
          // Column untuk memposisikan gambar dan tombol di tengah layar
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Set mainAxisSize menjadi min
              children: [
                // Gambar di tengah layar
                Center(
                  child: Container(
                    width: w * 0.7,
                    height: w * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.6),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "img/devjavu.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60), // Menggunakan SizedBox untuk memberikan jarak vertikal
                // Tombol Login di bawah gambar
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 182, 133, 93),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                    ),
                    child: const Text(
                      'Mulai',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}