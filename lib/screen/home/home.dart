import 'package:flutter/material.dart';
import 'package:flutter_gallery/screen/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    homeController.fetchWallpapers(homeController.categories[homeController.selectedCategory]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              searchBar(sWidth),
              categories(),
              wallpapers(),
            ],
          ),
        ),
      ),

    );


  }

  Widget header() {
    return const Center(child:Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("hd", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 25),),
          Text("Wallpaper", style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),),
        ],),
    ),);
  }

  Widget searchBar(double sWidth){
    TextEditingController controller = TextEditingController();
    return
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: EdgeInsets.symmetric(horizontal: 6),
        height: 50,width:sWidth,
        decoration: BoxDecoration(
          color:Colors.greenAccent.withOpacity(0.1),

          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 6
            ),

          ],

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(
                width: sWidth*0.6,
                child: TextFormField(
                  controller: controller,
                  decoration:InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none,


                  ),
                )
            ),
            const SizedBox(width: 15,),
            GestureDetector(
                onTap: (){
                  if(controller.text.isNotEmpty){
                    homeController.fetchWallpapers(controller.text);
                    controller.clear();
                  }
                },
                child: const Icon(Icons.search)),

          ],),);
  }

  Widget categories(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeController.categories.length,
            itemBuilder: (context, index){

              return GetBuilder<HomeController>(
                builder: (_){
                  return
                    GestureDetector(
                      onTap: (){
                        homeController.changeSelectedCategory(index);
                        print(homeController.selectedCategory);
                      },
                      child:
                      Container(
                        margin: const EdgeInsets.only(right:10),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: homeController.selectedCategory==index? Colors.teal:Colors.transparent,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(child: Text(homeController.categories[index], style: TextStyle(color: homeController.selectedCategory==index? Colors.white:Colors.black)),),
                      ),
                    );
                },
              );
            }
        ),
      ),
    );
  }

  Widget wallpapers(){
    return GetBuilder<HomeController>(builder: (_){
      return
        Skeletonizer(
          enabled: homeController.data.isNotEmpty?false:true,
          ignoreContainers: true,
          child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount:homeController.data.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                double ht=index%2==0?250:200;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed("wallpaper",
                      arguments:homeController.data[index]['urls']['regular'] );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(homeController.data[index]['urls']['regular'],
                        height: ht,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
        );


        // homeController.data.isNotEmpty?MasonryGridView.count(
        //     crossAxisCount: 2,
        //     itemCount:homeController.data.length,
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemBuilder: (context,index){
        //       double ht=index%2==0?250:200;
        //       return Padding(
        //         padding: const EdgeInsets.all(10),
        //         child: GestureDetector(
        //           onTap: (){Get.to('wallpaper', arguments:homeController.data[index]['urls']['regular'] ); },
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(12),
        //             child: Image.network(homeController.data[index]['urls']['regular'],
        //               height: ht,
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),
        //       );
        //     })
        //     :Container(
        //     height: 500,
        //     child: Center(child: SpinKitCircle(color: Colors.grey),));
    });




  // });
  }

}
