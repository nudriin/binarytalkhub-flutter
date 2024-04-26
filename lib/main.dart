import 'package:binarytalk/app/widgets/splash.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   title: 'Application',
    //   initialRoute: Routes.LOGIN,
    //   getPages: AppPages.routes,
    //   debugShowCheckedModeBanner: false,
    // );
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)),
        builder: (context, snapshot) {
          // ! selama masih nunggu maka akan ditampilkan splash screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: BackgroundVideo(),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return GetMaterialApp(
              title: 'Application',
              initialRoute: Routes.LOGIN,
              getPages: AppPages.routes,
              debugShowCheckedModeBanner: false,
            );
          }
        });
  }
}
