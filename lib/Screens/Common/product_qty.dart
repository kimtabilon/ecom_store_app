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
  final ValueChanged<int> update;
  const DropdownQTY(this.update,{Key? key}) : super(key: key);
  @override
  State<DropdownQTY> createState() => _DropdownQTYState();
}

class _DropdownQTYState extends State<DropdownQTY> {
  String dropdownValue = '1';
  final MyController c = Get.put(MyController());

  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    if(size.width > 600) {
      if(int.parse(dropdownValue) >= 1 && int.parse(dropdownValue) <= 10) {
        return DropdownButton<String>(
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.lightGreen,
          value: dropdownValue,
          items: <String>[
            '1','2','3','4','5','6','7','8','9','10+'
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
              if(newValue == '10+') {
                newValue = '10';
              }
              setState(() {
                dropdownValue = newValue!;
              });
              int newQTY = int.parse(newValue!);
              c.qty.value = newQTY;
              unitCodeCtrlFocusNode.requestFocus();
              widget.update(newQTY);
            });
          },
        );
      } else {
        return Container(
          width: 80,
          child: TextField(
            focusNode: unitCodeCtrlFocusNode,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
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
              setState(() {
                dropdownValue = str;
              });

              int newQTY = int.parse(str!);
              c.qty.value = newQTY;
              unitCodeCtrlFocusNode.requestFocus();
              widget.update(newQTY);
            },
          ),
        );
      }
    } else {
      if(int.parse(dropdownValue) >= 1 && int.parse(dropdownValue) < 10) {
        return DropdownButton<String>(
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.lightGreen,
          value: dropdownValue,
          items: <String>[
            '1','2','3','4','5','6','7','8','9','10+'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if(newValue == '10+') {
                newValue = '10';
              }
              setState(() {
                dropdownValue = newValue!;
              });
              int newQTY = int.parse(newValue!);
              c.qty.value = newQTY;
              unitCodeCtrlFocusNode.requestFocus();
              widget.update(newQTY);
            });
          },
        );
      } else {
        return Container(
          width: 80,
          child: TextField(
            focusNode: unitCodeCtrlFocusNode,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                border: InputBorder.none,
                hintText: 'Input QTY',
                hintStyle: TextStyle(
                    color: Colors.white
                ),
                helperStyle: TextStyle(
                    color: Colors.white
                )
            ),
            onChanged: (String str) {

              int newQTY = int.parse(str!);
              c.qty.value = newQTY;
              widget.update(newQTY);

              if(int.parse(str) > 9){
                setState(() {
                  dropdownValue = str;
                });
                unitCodeCtrlFocusNode.requestFocus();
              }

            },
            onSubmitted: (String str) {
              setState(() {
                dropdownValue = str;
              });
              unitCodeCtrlFocusNode.requestFocus();
              int newQTY = int.parse(str!);
              c.qty.value = newQTY;
              widget.update(newQTY);
            },
          ),
        );
      }
    }
  }
}