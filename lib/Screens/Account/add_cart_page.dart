import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../Provider/StoreProvider/add_to_cart_provider.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class CreateCartPage extends StatefulWidget {
  const CreateCartPage({Key? key}) : super(key: key);

  @override
  State<CreateCartPage> createState() => _CreateCartPageState();
}

class _CreateCartPageState extends State<CreateCartPage> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'SKU',
                    controller: _title,
                    hint: 'Input SKU',
                  ),
                  /*Consumer<AddToCartProvider>(builder: (context, addCart, child) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (addCart.getResponse != '') {
                        showMessage(
                            message: addCart.getResponse, context: context);

                        ///Clear the response message to avoid duplicate
                        addCart.clear();
                      }
                    });
                    return customButton(
                      status: addCart.getStatus,
                      text: 'Add to Cart',
                      tap: () {
                        if (_title.text.isEmpty) {
                          showMessage(
                              message: "Fill in SKU", context: context);
                        } else {
                          addCart.addCart(title: _title.text.trim());
                        }
                      },
                      context: context,
                    );
                  })*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
