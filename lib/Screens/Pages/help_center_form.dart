import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HelpCenterForm extends StatefulWidget {
  const HelpCenterForm({Key? key}) : super(key: key);

  @override
  State<HelpCenterForm> createState() => _HelpCenterFormState();
}

class _HelpCenterFormState extends State<HelpCenterForm> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _fnameController = TextEditingController(text: 'Enter your firstname');
  final _lnameController = TextEditingController(text: 'Enter your lastname');
  final _contactController = TextEditingController(text: 'Enter your contact number');

  final _bodyController = TextEditingController(
    text: 'Write your message here',
  );

  Future<void> send() async {
    final Email email = Email(
      body: "From: "+_fnameController.text+" "+_lnameController.text+" - Message: "+_bodyController.text,
      subject: 'Sent from Ecom Store App',
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _recipientController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Recipient',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _fnameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Firstname',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _lnameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Lastname',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _contactController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contact Number',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _bodyController,
            maxLines: 3,
            // expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
                labelText: 'Message', border: OutlineInputBorder()),
          ),
        ),
        Container(
          height: 44.0,
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink, Colors.green])),
          child: ElevatedButton(
            onPressed: () { send; },
            style: ElevatedButton.styleFrom(shadowColor: Colors.transparent),
            child: Text('Send'),
          ),
        )
        /*CheckboxListTile(
          contentPadding:
          EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          title: Text('HTML'),
          onChanged: (bool? value) {
            if (value != null) {
              setState(() {
                isHTML = value;
              });
            }
          },
          value: isHTML,
        ),*/

      ],
    );
  }
}