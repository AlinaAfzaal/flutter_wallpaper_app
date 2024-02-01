import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class HomeController extends GetxController{

  var selectedCategory = 0;
  List data=[];
  final categories = [
    "Aesthetic",
    "Technology",
    "Nature",
    "Food",
    "Adventure",
    "Travel"
  ];

  fetchWallpapers(String query) async {
    data=[];
    final url=Uri.parse('https://api.unsplash.com/search/photos/?client_id=geOntktu0y--DGbhkUvGEaYk6ILZhvdyzuqsIcvT59E&query=$query&per_page=30');
    var response=await http.get(url);
    var result=jsonDecode(response.body);
    data=result['results'];
    print(data);
    update();
  }

  void changeSelectedCategory(int index){
    data = [];
    selectedCategory = index;
    fetchWallpapers(categories[index]);
    update();
  }

}
