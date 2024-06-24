import 'package:client_dev_ja_vu/controller/login_controller.dart';
import 'package:client_dev_ja_vu/user_auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true; // Untuk mengontrol visibilitas teks password

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 148, 45, 38),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 20),
                Column(
                  children: [
                    logoWidget("img/devjavu.jpeg"),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 196, 195, 195),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(19),
                      child: Column(
                        children: [
                          // TextField untuk Email
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 73, 73, 73),
                                  fontFamily: 'Alegreya',
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // Warna latar belakang putih
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  controller: ctrl.loginNameCtrl,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                    hintText: 'Enter your username',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6), // Jarak antara TextField
                          // TextField untuk Password
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 73, 73, 73),
                                  fontFamily: 'Alegreya',
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    TextField(
                                      controller: ctrl.loginPasswordCtrl,
                                      keyboardType: TextInputType.text,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: const Icon(Icons.lock),
                                        hintText: 'Enter your password',
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Password dan Forgot Password
                              GestureDetector(
                                onTap: () {
                                  // Tambahkan logika di sini untuk Forgot Password
                                  // Contoh: Navigasi ke halaman reset password
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 0),
                                  child: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 73, 73, 73),
                                      fontFamily: 'Alegreya',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20), // Jarak antara Forgot Password dan tombol Masuk
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    ctrl.loginWithUsernameAndPassword();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color.fromARGB(255, 182, 133, 93),
                                  ),
                                  child: const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontFamily: 'Alegreya',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30), // Jarak antara container dan teks 'lala'
                    Text(
                      'Saskia Lavinsky 535220176',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Shannon Andrea 535220204 | Marvin Gultom 535220198',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Aulia Dwi Y. 535220178 | Nashwa Sawitri D. 535220220',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(RegisterPage());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: RichText(
                      text: TextSpan(
                        text: 'Tidak punya akun? ',
                        style: TextStyle(fontFamily: 'Alegreya', fontSize: 16, color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Daftar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Alegreya',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget logoWidget(String imageName) {
    return ClipOval(
      child: Image.asset(
        imageName,
        fit: BoxFit.cover,
        width: 180,
        height: 180,
      ),
    );
  }
}
