import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<dynamic> arr = <dynamic>[].obs; // Fixing the type to RxList<dynamic>

  @override
  void onInit() {
    super.onInit();
    getData(); // Correcting the onInit method
  }

  Future<void> getData() async {
    var uri = Uri.parse('https://fruit-api-tnzc.onrender.com/fruit_api');
    var data = await http.get(uri);
    var res = jsonDecode(data.body);
    arr.value = res; // Update the observable list
  }
  void delete_my_fruit(int index)
  {
    arr.removeAt(index);
  }
}
