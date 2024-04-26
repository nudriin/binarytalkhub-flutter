import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 23, 42, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 27, color: Colors.white, fontFamily: 'Futura'),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                'assets/images/password.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 25),
              TextField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Masukan username anda...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(
                        color: Color(0xFF7E30E1),
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Masukan password anda...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(
                      color: Color(0xFF7E30E1),
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.login(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(500, 50),
                  backgroundColor: Color(0xFF7E30E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      text: "Belum punya akun? ",
                      style: TextStyle(color: Colors.white),
                      children: [
                    TextSpan(
                        text: "Daftar",
                        style: TextStyle(color: Colors.blue[600]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse(
                                'https://binarytalkhub.pemweb.cloud/sign-up'));
                          })
                  ]))
            ],
          ),
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
