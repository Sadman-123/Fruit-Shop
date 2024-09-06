import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/screen/home.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}



