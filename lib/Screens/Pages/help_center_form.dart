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
    text: '',
  );

  final _fnameController = TextEditingController(text: '');
  final _lnameController = TextEditingController(text: '');
  final _contactController = TextEditingController(text: '');

  final _bodyController = TextEditingController(
    text: '',
  );

  Future<void> send() async {
    String platformResponse;
    if(_fnameController.text.isEmpty
        || _contactController.text.isEmpty
        ||_lnameController.text.isEmpty
        ||_bodyController.text.isEmpty
    ||_recipientController.text.isEmpty){
      platformResponse = "All fields are required.";
    }else{
      final Email email = Email(
        body: "From: "+_fnameController.text+" "+_lnameController.text+" - Message: "+_bodyController.text,
        subject: 'Sent from Ecom Store App',
        recipients: [_recipientController.text],
        attachmentPaths: attachments,
        isHTML: isHTML,
      );



      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        print(error);
        platformResponse = error.toString();
      }

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
          child: ElevatedButton(
            onPressed: send,
            style: ElevatedButton.styleFrom(shadowColor: Colors.transparent, backgroundColor: Color.fromRGBO(43,102,145,1)),
            child: Text('Submit'),
          ),
        )


      ],
    );
  }
}