import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final RxString messages = ''.obs;
  final RxBool isLoading = false.obs;

  // ignore: body_might_complete_normally_nullable
  Future<String?> uploadFile(String filePath) async {
    updateLoading(true);
    String? authToken = await getToken();
    final Uri apiUrl =
        Uri.parse('https://api-binary-talk.vercel.app/api/summarize/pdf');

    final file = File(filePath);
    if (!file.existsSync()) {
      print('File not found');
      return 'File not found';
    }

    var request = http.MultipartRequest('POST', apiUrl)
      ..headers.addAll({
        'Authorization': 'Bearer $authToken',
      })
      ..files.add(await http.MultipartFile.fromPath('pdfFile', filePath));

    try {
      final streamedResponse = await request.send();
      final responseString = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> response = jsonDecode(responseString.body);

      if (responseString.statusCode == 200) {
        print(response['data']['message']);
        updateLoading(false);
        return response['data']['message'];
      } else {
        print(responseString.body);
        print(response['errors']);
        updateLoading(false);
        Get.snackbar('Upload Status', response['errors'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Color(0xFF7E30E1));
      }
    } catch (e) {
      print('Error uploading file: $e');
      isLoading.value = false;
      return 'Error uploading file: $e';
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? timestamp = prefs.getInt('token_timestamp');

    if (token != null && timestamp != null) {
      DateTime tokenTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      DateTime now = DateTime.now();

      if (now.difference(tokenTime).inHours >= 1) {
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

  void updateMessages(String message) {
    messages.value = message;
  }

  void updateLoading(bool loading) {
    isLoading.value = loading;
  }
}
