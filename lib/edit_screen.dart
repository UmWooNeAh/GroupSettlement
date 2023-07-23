import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_settlement/class_user.dart';
import 'package:group_settlement/fire_service.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class EditScreen extends StatelessWidget {
  final User user;
  EditScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: "${user.Name}");
    logger.d(user.Name);
    logger.d(user.reference);

    return Scaffold(
      appBar: AppBar(title: const Text("EDIT SCREEN")),
      body: Row(
        children: [
          Expanded(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "input message",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
              )),
              TextButton(
                  onPressed: () {
                    User updateModel =
                        User(Name: controller.text);
                    FireService().updateCollection(
                        reference: user.reference!, json: updateModel.toJson());
                    Navigator.of(context).pop(true);
                  },
                  child: const Icon(Icons.send)),
        ],
      ),
    );
  }
}

