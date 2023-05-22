import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
class JobOpportunitiesForm extends StatefulWidget {
  const JobOpportunitiesForm({Key? key}) : super(key: key);

  @override
  State<JobOpportunitiesForm> createState() => _JobOpportunitiesFormState();
}

class _JobOpportunitiesFormState extends State<JobOpportunitiesForm> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _fnameController = TextEditingController(text: '');
  final _lnameController = TextEditingController(text: '');
  final _contactController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _bodyController = TextEditingController(
    text: '',
  );

  Future<void> send() async {
    String platformResponse;
    if(_fnameController.text.isEmpty
    || _contactController.text.isEmpty
    ||_emailController.text.isEmpty
    ||_bodyController.text.isEmpty){
      platformResponse = "All fields are required.";
    }else{
      final Email email = Email(
        body: "From: "+_fnameController.text+" - Email: "+_emailController.text+" - Message: "+_bodyController.text,
        subject: 'Job Opportunities',
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
        // Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: TextField(
        //     controller: _recipientController,
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(),
        //       labelText: 'Recipient',
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _fnameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Full Name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: TextField(
        //     controller: _lnameController,
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(),
        //       labelText: 'Lastname',
        //     ),
        //   ),
        // ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Resume"),
              for (var i = 0; i < attachments.length; i++)
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        attachments[i],
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () => {_removeAttachment(i)},
                    )
                  ],
                ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: _openImagePicker,
                  ),
                ),
              ),
              TextButton(
                child: Text('Attach file in app documents directory'),
                onPressed: () => _attachFileFromAppDocumentsDirectoy(),
              ),
            ],
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

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }


  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> _attachFileFromAppDocumentsDirectoy() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = appDocumentDir.path + '/file.txt';
      final file = File(filePath);
      await file.writeAsString('Text file in app directory');

      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create file in applicion directory'),
        ),
      );
    }
  }



}

