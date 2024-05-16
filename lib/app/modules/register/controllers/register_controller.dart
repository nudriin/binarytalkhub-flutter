import 'dart:convert';
import 'package:binarytalk/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    String username = usernameController.text;
    String email = emailController.text;
    String name = nameController.text;
    String password = passwordController.text;

    const apiUrl = 'https://api-binary-talk.vercel.app/api/users';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'name': name,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Get.snackbar(
          'Sukses',
          'Berhasil mendaftar!',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Color(0xFF7E30E1),
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Get.snackbar(
          'Error',
          responseData['errors'],
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Color(0xFF7E30E1),
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
