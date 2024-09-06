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
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Fruits',
            style: TextStyle(
                fontSize: mq.width * 0.08, fontWeight: FontWeight.w900)),
      ),
      body: Obx(() {
        if (home.arr.isEmpty) {
          return Center(
              child: LoadingAnimationWidget.beat(
                  color: Colors.blueAccent, size: 50)); // Show loader
        }
        return ListView.builder(
          itemCount: home.arr.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(index.toString()),
              child: _Custom_Card(arr: home.arr, index: index),
              background: Container(),
              onDismissed: (direction) {},
            );
          },
        );
      }),
    );
  }
}

class _Custom_Card extends StatelessWidget {
  final dynamic arr;
  final int index;

  _Custom_Card({required this.arr, required this.index});

  @override
  Widget build(BuildContext context) {
    var mdq = MediaQuery.of(context).size.width;
    HomeController home = Get.find<HomeController>(); // Find existing controller

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Obx only where observable is used
            Hero(
              tag: "${arr[index]['code']}",
              child: Obx(() => Skeletonizer(
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
                    image: home.arr.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage("${home.arr[index]['pic']}"),
                      fit: BoxFit.cover,
                    )
                        : null,
                    borderRadius: const BorderRadius.only(
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
                    color: home.arr.isEmpty
                        ? Colors.grey[300]
                        : null, // Color for skeleton
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
              )),
            ),
            Expanded(
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Only wrap the part that needs to observe the data change
                          Text(
                            "${arr[index]['item']}",
                            style: TextStyle(
                                fontSize: mdq * 0.06, fontWeight: FontWeight.w600),
                          ),
                          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Product Code: ",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: mdq * 0.05)),
                                TextSpan(
                                    text: "${arr[index]['code']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: mdq * 0.05)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Quantity: ",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: mdq * 0.05)),
                                TextSpan(
                                    text: "${arr[index]['quantity']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: mdq * 0.05)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          "${arr[index]['price']}\$",
                          style: TextStyle(
                              fontSize: mdq * 0.07, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Get.to(Details(lst: arr, ind: index));
      },
    );
  }
}
