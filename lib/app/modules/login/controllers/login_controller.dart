import 'dart:convert';
import 'package:binarytalk/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    const apiUrl = 'https://binarytalkhub.pemweb.cloud/api/users/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['data']['token'];

        // Menyimpan token beserta timestamp
        await saveTokenWithTimestamp(token);

        Get.offAllNamed(Routes.HOME);
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Get.snackbar('Error', responseData['errors'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Color(0xFF7E30E1));
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

  Future<void> saveTokenWithTimestamp(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    // Menyimpan timestamp saat token disimpan
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    await prefs.setInt('token_timestamp', timestamp);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? timestamp = prefs.getInt('token_timestamp');

    if (token != null && timestamp != null) {
      // Memeriksa apakah token sudah lebih dari 1 jam
      DateTime tokenTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      DateTime now = DateTime.now();

      if (now.difference(tokenTime).inHours >= 1) {
        // Hapus token jika sudah lebih dari 1 jam
        await deleteToken();
        return null;
      } else {
        return token;
      }
    }
    return null;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('token_timestamp');
  }
}
