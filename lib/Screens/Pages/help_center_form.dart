import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Constants/url.dart';

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

  final _bodyController = TextEditingController(text: '',);

  Future<String> mailer(from, fname, lname, number, message) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse('https://'+AppUrl.consoleUrl+'/api/v1/mailer/help-center'));
    request.body = json.encode({
      'from': from,
      'fname': fname,
      'lname': lname,
      'number': number,
      'message': message,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return 'success';
    /*try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/mailer/help-center/"
      );
      var response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'from': from,
          'fname': fname,
          'lname': lname,
          'number': number,
          'message': message,
        }),
      );

      //var response = await http.get(uri);

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw data["message"];
      }
      return data["image"];
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }*/
  }

  Future<void> send() async {
    String platformResponse;
    if(_fnameController.text.isEmpty
        || _contactController.text.isEmpty
        ||_lnameController.text.isEmpty
        ||_bodyController.text.isEmpty
    ||_recipientController.text.isEmpty){
      platformResponse = "All fields are required.";
    }else{
      /*final Email email = Email(
        body: "From: "+_fnameController.text +" "
            +_lnameController.text
            +" \n Email:"+_recipientController.text+" "
            +" \n Contact No.:"+_contactController.text+" "
            +" \n Message: "+_bodyController.text,
        subject: 'Sent from Ecom Store App',
        recipients: ["devteam@ecommercebusinessprime.com"],
        attachmentPaths: attachments,
        isHTML: isHTML,
      );*/
      try {
        await mailer(_recipientController.text, _fnameController.text, _lnameController.text, _contactController.text, _bodyController.text);
        // await FlutterEmailSender.send(email);
        platformResponse = 'Message sent!';
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