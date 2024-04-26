import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(15, 23, 42, 1),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: Clipping(),
            child: Container(
              height: 250,
              width: Get.width,
              color: Color.fromRGBO(15, 23, 42, 1),
              child: Column(
                children: [
                  Text(
                    'PDF Sumarizer',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Futura',
                        fontSize: 28),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Powered by ',
                        style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'ChatGPT',
                            style: TextStyle(
                              color: Color(0xFF7E30E1),
                              fontFamily: 'Futura',
                              fontSize: 10,
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  height: Get.height * 0.3,
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: ClipForBox(),
                        child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF7E30E1),
                                Color(0xFF49108B),
                              ]),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 170,
                            width: Get.width,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  'Selamat Datang!',
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      fontSize: 20,
                                      color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                                Text("Upload PDF anda",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[300],
                                    )),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => fileInput(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(15, 23, 42, 1),
                                    fixedSize: Size(120, 60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.file_upload_outlined,
                                    color: Colors.white,
                                    size: 30,
                                    weight: 400,
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 4,
                  color: Colors.grey[200],
                ),
                Expanded(
                    child: Container(
                  height: 100,
                  child: ListView(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: Obx(
                          () {
                            if (controller.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF7E30E1),
                                ),
                              );
                            } else {
                              if (controller.messages.value.isEmpty) {
                                return Image.asset(
                                  'assets/images/question.png',
                                  height: 250,
                                  width: 250,
                                );
                              } else {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: controller.messages.value));
                                        Get.snackbar(
                                            'Disalin!', 'Teks berhasil disalin',
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            backgroundColor: Color(0xFF7E30E1));
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 2),
                                          Text(
                                            "Klik untuk menyalin!",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 8),
                                          AnimatedTextKit(
                                            animatedTexts: [
                                              TypewriterAnimatedText(
                                                controller.messages.value,
                                                textStyle: TextStyle(
                                                    fontFamily: 'Poppins'),
                                                speed:
                                                    Duration(milliseconds: 10),
                                                cursor: '|',
                                              ),
                                            ],
                                            isRepeatingAnimation: false,
                                            repeatForever: false,
                                            displayFullTextOnTap: true,
                                            totalRepeatCount: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void fileInput() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      print("File path: $filePath");

      String? uploadResponse = await HomeController().uploadFile(filePath!);
      if (uploadResponse != null) {
        // Menampilkan pesan respons ke pengguna
        controller.updateMessages(uploadResponse);
      }
    } else {
      print("User canceled the picker");
    }
  }
}

class Clipping extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipForBox extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width - 70, size.height);
    path.lineTo(size.width, size.height - 70);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
