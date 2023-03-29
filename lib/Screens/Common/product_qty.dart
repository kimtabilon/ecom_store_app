import 'package:get/get.dart';

class MyController extends GetxController {
  var qty = 1.obs;

  increment() {
    qty.value++;
  }

  decrement() {
    if(qty.value > 1){
      qty.value--;
    } else {
      qty.value = 1;
    }
  }
}