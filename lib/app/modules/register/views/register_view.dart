import 'package:binarytalk/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
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
              SizedBox(height: 70),
              Text(
                "Register",
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
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Masukan email anda...",
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
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Masukan nama anda...",
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
                onPressed: () => controller.register(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(500, 50),
                  backgroundColor: Color(0xFF7E30E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: Text(
                  "Daftar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      text: "Sudah punya akun? ",
                      style: TextStyle(color: Colors.white),
                      children: [
                    TextSpan(
                        text: "Masuk",
                        style: TextStyle(color: Colors.blue[600]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.offAllNamed(Routes.LOGIN))
                  ]))
            ],
          ),
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
