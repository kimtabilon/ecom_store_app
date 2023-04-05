import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Provider/Database/db_provider.dart';

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

  var curr = 1.obs;
  change() {
    curr.value = curr.value;
  }

  var curr2 = 1.obs;
  change2() {
    curr2.value = curr2.value;
  }

  var curr3 = 1.obs;
  change3() {
    curr3.value = curr3.value;
  }

  var name = ''.obs;
  nm() {
    FutureBuilder(
        future: DatabaseProvider().getData('name'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text("${snapshot.data}");
          } else {
            return Text("Hi ...");
          }
        }
    );
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
    print(dropdownValue);

    Size size = MediaQuery.of(context).size;

    if(size.width > 600) {
      if(int.parse(dropdownValue) >= 1 && int.parse(dropdownValue) <= 10) {
        return DropdownButton<String>(
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.lightGreen,
          value: dropdownValue,
          items: <String>[
            '1','2','3','4','5','6','7','8','9','10','11'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 28,
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
      } else {
        return Container(
          width: 30,
          child: TextField(
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                border: InputBorder.none,
                hintText: dropdownValue,
                hintStyle: TextStyle(
                    color: Colors.white
                ),
                helperStyle: TextStyle(
                    color: Colors.white
                )
            ),
            onSubmitted: (String str) {
              dropdownValue = str;
              int newQTY = int.parse(str!);
              c.qty.value = newQTY;
              print(c.qty.value);
            },
          ),
        );
      }
    } else {
      if(int.parse(dropdownValue) >= 1 && int.parse(dropdownValue) <= 10) {
        return DropdownButton<String>(
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.lightGreen,
          value: dropdownValue,
          items: <String>[
            '1','2','3','4','5','6','7','8','9','10','11'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 16,
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
      } else {
        return Container(
          width: 30,
          child: TextField(
            style: TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                border: InputBorder.none,
                hintText: dropdownValue,
                hintStyle: TextStyle(
                    color: Colors.white
                ),
                helperStyle: TextStyle(
                    color: Colors.white
                )
            ),
            onSubmitted: (String str) {
              dropdownValue = str;
              int newQTY = int.parse(str!);
              c.qty.value = newQTY;
              print(c.qty.value);
            },
          ),
        );
      }
    }


  }
}