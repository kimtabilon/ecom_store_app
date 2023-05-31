import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../Model/order_model.dart';
import '../../Widgets/appbar_widget.dart';
import '../Account/Local_widget/cart_image_widget.dart';
import 'package:http/http.dart' as http;
import '../../Constants/url.dart';

class RMADetails extends StatefulWidget {
  const RMADetails({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;
  @override
  State<RMADetails> createState() => _RMADetailsState();
}

class _RMADetailsState extends State<RMADetails> {
  int min = 1;
  int max = 1;

  final List<String> reasons = [
    'Arrived Late',
    'Bought by mistake',
    'Damaged',
    'Didn\'t approve purchase',
    'Inaccurate website description',
    'Inadequate Quality',
    'Incompatible or not useful',
    'Item arrived too late',
    'Item defective or doesn\'t work',
    'Missing parts or accessories',
    'No longer needed',
    'Ordered wrong style/size/color',
    'Performance or quality not adequate',
    'Product and shipping box both damaged',
    'Product damaged, but shipping box OK',
    'Received extra item I didnt buy (no refund needed)',
    'Wrong item was sent',
    'Wrong Size/Poor Fit',
    'Return To Shipper',
    'Lost Package',
    'Others',
  ];

  List<Map<String, dynamic>> return_items = [];

  @override
  void initState() {
    for (int i = 0; i < widget.order.items!.length; i++) {
      setState(() {
        return_items.add({
          'order': '',
          'sku': '',
          'qty': '0',
          'name': '',
          'reason': '',
          'comments': '',
          'dropdown':null
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppbarWidget(title: '', leadingButton: '',)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Align(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Return Management Form",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
              const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('ITEMS ORDERED')
              ),
              ...widget.order.items!.map((item) {
                int idx = widget.order.items!.indexOf(item);
                return_items[idx]['sku'] = item.sku;
                return_items[idx]['name'] = item.name;
                return_items[idx]['ordered_qty'] = item.qty_ordered.toString();
                return_items[idx]['order'] = widget.order.id;
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(item.sku!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name!),
                                  Text("Ordered QTY: ${item.qty_ordered}"),
                                  Row(
                                    children: [
                                      const Text("Return QTY: "),
                                      SizedBox(
                                        width: 20,
                                        child: TextField(
                                          decoration: const InputDecoration(
                                              hintText: "0"
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            int x;
                                            try {
                                              x = int.parse(value);
                                              max = int.parse(item.qty_ordered.toString());
                                            } catch (error) {
                                              x = min;
                                              max = int.parse(item.qty_ordered.toString());
                                            }
                                            if (x < min) {
                                              x = min;
                                            } else if (x > max) {
                                              x = max;
                                            }

                                            setState(() {
                                              return_items[idx]['qty'] = x.toString();
                                            });

                                            /*_textEditingController.value = TextEditingValue(
                                                text: x.toString(),
                                                selection: TextSelection.fromPosition(
                                                  TextPosition(offset: _textEditingController.value.selection.baseOffset),
                                                ),
                                              );*/
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Text("\$${item.price!}"),
                              leading: CartItemImageWidget(sku: item.sku!),
                              // style: ListTitleStyle(),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: const Text(
                                  'Why are you returning this',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: reasons.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList(),
                                value: return_items[idx]['dropdown'],
                                onChanged: (value) {
                                  setState(() {
                                    return_items[idx]['reason'] = value.toString();
                                    return_items[idx]['dropdown'] = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  height: 50,
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: double.infinity,
                                  padding: null,
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all<double>(6),
                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (String value) {
                                  setState(() {
                                    return_items[idx]['comments'] = value.toString();
                                  });
                                },
                                maxLines: 3,
                                // expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                    hintText: "Describe what's wrong with the item...",
                                    labelText: 'Comments (required)', border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        )
                    )
                );
              }
              ).toList(),
              const SizedBox(
                height: 30,
              ),

              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          submitRMA(json.encode(return_items));
                        },
                        child: const Text('Submit RMA'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(16,69,114,1),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );

  }

  Future<String> submitRMA(json) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse('https://'+AppUrl.consoleUrl+'/api/v1/submit-rma'));
    request.body = json;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return 'success';
  }

}

class CheckBoxModal {
  String title;
  bool value;

  CheckBoxModal({required this.title, this.value = false});
}