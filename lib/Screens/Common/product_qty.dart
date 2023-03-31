import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

class DropdownQTY extends StatefulWidget {
  const DropdownQTY({Key? key}) : super(key: key);
  @override
  State<DropdownQTY> createState() => _DropdownQTYState();
}

class _DropdownQTYState extends State<DropdownQTY> {
  String dropdownValue = '1';
  final MyController c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.lightGreen,
      value: dropdownValue,
      items: <String>[
        '1','2','3','4','5','6','7','8','9','10'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          int newQTY = int.parse(newValue!);
          c.qty.value = newQTY;
          print(c.qty.value);
        });
      },
    );
  }
}