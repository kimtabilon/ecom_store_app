import 'package:flutter/material.dart';

class CartField extends StatefulWidget {
  CartField(
      {Key? key,
      this.title,
      this.taskId,
      this.isCompleted,
      this.initial,
      this.subtitle})
      : super(key: key);

  final String? title;
  final String? subtitle;
  final String? taskId;
  final String? initial;

  bool? isCompleted;

  @override
  _CartFieldState createState() => _CartFieldState();
}

class _CartFieldState extends State<CartField> {
  @override
  Widget build(BuildContext context) {
    return Text('cart view 123!');
    /*return ListTile(
      onTap: () {
        PageNavigator(ctx: context).nextPage(
            page: CartDetailsPage(
          taskId: widget.taskId,
          title: widget.title,
        ));
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        widget.title!,
        style: TextStyle(
          decoration: widget.isCompleted == true
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.subtitle!,
        style: TextStyle(
          decoration: widget.isCompleted == true
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundColor: widget.isCompleted == true ? green : amber,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: CircleAvatar(
            backgroundColor: lightAmber,
            child: Text(widget.initial!),
          ),
        ),
      ),
      trailing: Checkbox(
        onChanged: (value) {
          setState(() {
            widget.isCompleted = value!;
          });
        },
        value: widget.isCompleted,
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            return widget.isCompleted == true ? green : grey.withOpacity(0.20);
          },
        ),
      ),
    );*/
  }
}
