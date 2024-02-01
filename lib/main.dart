import 'package:flutter/material.dart';
import 'package:flutter_gallery/screen/home/home.dart';
import 'package:flutter_gallery/screen/wallpaper/wallpaper.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App ',
      theme: ThemeData(
        brightness: Brightness.light,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      routes: {
        '/': (context)=>MyHomePage(),
        'wallpaper': (context)=>Wallpaper()

      },
    );
  }
}
