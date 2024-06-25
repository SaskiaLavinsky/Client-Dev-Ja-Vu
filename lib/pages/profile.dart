import 'package:client_dev_ja_vu/components/custom_button.dart';
import 'package:client_dev_ja_vu/user_auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String username;
  late String email;
  late String phoneNumber; // Ubah tipe data menjadi String

  @override
  void initState() {
    super.initState();
    GetStorage box = GetStorage();
    var user = box.read('loginUser');
    username = user['name'] ?? 'No Username';
    email = user['email'] ?? 'No Email';
    phoneNumber = user['phoneNumber'] ?? 'No Phone Number'; // Baca nomor telepon dari loginUser
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 148, 45, 38),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          // Profile picture
          Icon(
            Icons.person,
            size: 100,
            color: const Color.fromARGB(255, 196, 195, 195),
          ),

          SizedBox(height: 40),

          // Username
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Alegreya',
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: double.infinity, // Match parent width
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    username,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: 'Alegreya',
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Alegreya',
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: double.infinity, // Match parent width
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    email,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: 'Alegreya',
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Phone Number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phone Number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Alegreya',
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: double.infinity, // Match parent width
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    phoneNumber,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: 'Alegreya',
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 50),

          // Logout Button
          CustomButton(
            text: "Logout",
            onPress: () {
              GetStorage box = GetStorage();
              box.erase();
              Get.offAll(LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
