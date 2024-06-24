import 'package:client_dev_ja_vu/model/user/user.dart';
import 'package:client_dev_ja_vu/pages/Utama.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerEmailCtrl = TextEditingController();
  TextEditingController registerPasswordCtrl = TextEditingController();
  TextEditingController registerPhoneCtrl = TextEditingController();

  TextEditingController loginNameCtrl = TextEditingController();
  TextEditingController loginPasswordCtrl = TextEditingController();

  User? loginUser;

  @override
  void onReady() {
    Map<String,dynamic>? user = box.read('loginUser');
    if(user != null){
      loginUser = User.fromJson(user);
      Get.to(const Utama());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  Future<void> addUser() async {
    try {
      String email = registerEmailCtrl.text.trim();
      String username = registerNameCtrl.text.trim();
      String password = registerPasswordCtrl.text;
      String phoneNumber = registerPhoneCtrl.text.trim();

      // Validasi Email
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        Get.snackbar('Error', 'Please enter a valid email address', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Validasi Username
      if (username.length < 3 || !RegExp(r'^[a-zA-Z]+$').hasMatch(username)) {
        Get.snackbar('Error', 'Username must be at least 3 characters long and contain only alphabets', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Validasi Password
      if (password.length < 6) {
        Get.snackbar('Error', 'Password must be at least 6 characters long', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Validasi Nomor Telepon
      if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phoneNumber)) {
        Get.snackbar('Error', 'Please enter a valid phone number (10-15 digits)', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Cek apakah email sudah terdaftar
      var emailQuerySnapshot = await userCollection.where('email', isEqualTo: email).limit(1).get();
      if (emailQuerySnapshot.docs.isNotEmpty) {
        Get.snackbar('Error', 'Email is already registered', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Cek apakah username sudah terdaftar
      var usernameQuerySnapshot = await userCollection.where('name', isEqualTo: username).limit(1).get();
      if (usernameQuerySnapshot.docs.isNotEmpty) {
        Get.snackbar('Error', 'Username is already taken', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Semua validasi berhasil, tambahkan user
      DocumentReference doc = userCollection.doc();
      User user = User(
        id: doc.id,
        name: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      final userJson = user.toJson();
      await doc.set(userJson);
      Get.snackbar('Success', 'User added successfully', colorText: Colors.green, backgroundColor: Colors.grey[300]);

      // Bersihkan input fields setelah user berhasil didaftarkan
      registerEmailCtrl.clear();
      registerNameCtrl.clear();
      registerPasswordCtrl.clear();
      registerPhoneCtrl.clear();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red, backgroundColor: Colors.grey[300]);
      print(e);
    }
  }

  Future<void> loginWithUsernameAndPassword() async {
    try {
      String username = loginNameCtrl.text.trim();
      String password = loginPasswordCtrl.text;

      // Validasi Username
      if (username.isEmpty) {
        Get.snackbar('Error', 'Please enter a username', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      // Validasi Password
      if (password.isEmpty) {
        Get.snackbar('Error', 'Please enter a password', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        return;
      }

      var querySnapshot = await userCollection.where('name', isEqualTo: username).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>;

        String storedPassword = userData['password']; // Ambil password yang disimpan dari Firestore
        if (storedPassword == password) {
          box.write('loginUser', userData);
          loginNameCtrl.clear();
          loginPasswordCtrl.clear();
          Get.snackbar('Success', 'Login Successful', colorText: Colors.green, backgroundColor: Colors.grey[300]);
          Get.to(Utama());
        } else {
          Get.snackbar('Error', 'Incorrect password', colorText: Colors.red, backgroundColor: Colors.grey[300]);
        }
      } else {
        Get.snackbar('Error', 'User not found, please register', colorText: Colors.red, backgroundColor: Colors.grey[300]);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to login', colorText: Colors.red, backgroundColor: Colors.grey[300]);
      print('Failed to login: $error');
    }
  }
}
