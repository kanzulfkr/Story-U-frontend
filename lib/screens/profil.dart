import 'dart:io';

import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';
import 'login.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 40, right: 40),
      child: ListView(
        children: [
          Center(
            child: GestureDetector(
                child: Container(
              width: 110,
              height: 110,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(60),
              //       image: _imageFile == null
              //           ? user!.image != null
              //               ? DecorationImage(
              //                   image: NetworkImage('${user!.image}'),
              //                   fit: BoxFit.cover)
              //               : null
              //           : DecorationImage(
              //               image: FileImage(_imageFile ?? File('')),
              //               fit: BoxFit.cover),
              //       color: Colors.amber),
              // ),
              // onTap: () {
              //   getImage();
              // },
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: TextFormField(
              decoration: kInputDecoration('Name'),
              controller: txtNameController,
              validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
