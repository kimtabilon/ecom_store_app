/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/StoreProvider/delete_cart_provider.dart';
import '../../Styles/colors.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key, this.title, this.taskId}) : super(key: key);

  final String? title;
  final String? taskId;

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _title.text = widget.title!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
        ),
        actions: [
          Consumer<DeleteCartProvider>(builder: (context, deleteCart, child) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              if (deleteCart.getResponse != '') {
                showMessage(message: deleteCart.getResponse, context: context);

                ///Clear the response message to avoid duplicate
                deleteCart.clear();
              }
            });
            return IconButton(
              onPressed: deleteCart.getStatus == true
                  ? null
                  : () {
                deleteCart.deleteCart(
                          taskId: widget.taskId, ctx: context);
                    },
              icon: Icon(Icons.delete,
                  color: deleteCart.getStatus == true ? grey : white),
            );
          })
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'Title',
                    controller: _title,
                    hint: 'What do you want to do?',
                  ),
                  // customButton(
                  //   status: false,
                  //   text: 'Update',
                  //   tap: () {},
                  //   context: context,
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/
