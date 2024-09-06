import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controller/home_controller.dart';
import 'details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class Home extends StatelessWidget {
  final HomeController home = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Fruits',style: TextStyle(fontSize: 29,fontWeight: FontWeight.w900),),
      ),
      body: Obx(() {
        if (home.arr.isEmpty) {
          return Center(child: LoadingAnimationWidget.beat(color: Colors.blueAccent, size: 50)); // Show loader while fetching data
        }
        return ListView.builder(
          itemCount: home.arr.length,
          itemBuilder: (context, index) {
            return Obx(() => Dismissible(
              key: Key(index.toString()),
              child: _Custom_Card(home.arr, index),
              background: Container(),
              onDismissed: (direction) {
              },
            ));

          },
        );
      }),
    );
  }
  Widget _Custom_Card(dynamic arr,int index)
  {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Hero(tag: "${arr[index]['code']}", child:  Skeletonizer(
              enabled: home.arr.isEmpty,
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.cyanAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: home.arr.isNotEmpty ? DecorationImage(image: NetworkImage("${home.arr[index]['pic']}"), fit: BoxFit.cover,) : null, // No image if arr is empty
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(3, 5),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                    width: 2,
                  ),
                  color: home.arr.isEmpty ? Colors.grey[300] : null, // Color for skeleton
                ),
                child: home.arr.isEmpty
                    ? Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[500],
                    size: 50,
                  ),
                )
                    : null,
              ),
            ),),
            Expanded(
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${arr[index]['item']}",style: TextStyle(fontSize: 27,fontWeight: FontWeight.w600),),
                          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: "Product Code: ",style: TextStyle(color: Colors.black45)),
                                  TextSpan(text: "${arr[index]['code']}",style: TextStyle(color: Colors.black))
                                ],
                                style: TextStyle(fontSize: 19)
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: "Quantity: ",style: TextStyle(color: Colors.black45)),
                                  TextSpan(text: "${arr[index]['quantity']}",style: TextStyle(color: Colors.black))
                                ],
                                style: TextStyle(fontSize: 19)
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text("${arr[index]['price']}\$",style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500),),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        Get.to(Details(lst: arr,ind: index,));
      },
    );
  }
}