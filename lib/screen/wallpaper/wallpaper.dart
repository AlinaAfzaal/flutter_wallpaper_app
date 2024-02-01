import 'package:flutter/material.dart';
import 'package:flutter_gallery/screen/wallpaper/wallpaper_controller.dart';
import 'package:get/get.dart';

class Wallpaper extends StatelessWidget {
  const Wallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    final path = ModalRoute.of(context)!.settings.arguments as String ;
    WallpaperController wallpaperController = Get.put(WallpaperController());

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              path,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            height: 35,
            bottom: 35,
            left: MediaQuery.of(context).size.width*0.3,
            child:GestureDetector(
              onTap: (){
                wallpaperController.setWallpaper(path);
                var snackBar =  SnackBar(
                  content:  Text(wallpaperController.isWallpaperSet?"wallpaper has been set":"something went wrong", style: const TextStyle(color: Colors.white),),
                  duration: const Duration(seconds: 5),
                  backgroundColor:Colors.teal,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pushNamed(context, "/");
                },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color:Colors.teal,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(child: Text("set wallpaper", style: TextStyle(color:Colors.white)),),
              ),
            ),
          )
        ],
      ),
      );
  }
}
