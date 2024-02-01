import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class WallpaperController extends GetxController{

  bool isWallpaperSet = false;

  setWallpaper(String imagePath) async {
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imagePath);
      final bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
      isWallpaperSet = true;
      update();
    } on PlatformException {
    }
  }


}