import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                  decoration: kInputDecoration('Name')),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (val) =>
                      val!.isEmpty ? 'Invalid email address' : null,
                  decoration: kInputDecoration('Email')),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Required at least 6 charachter' : null,
                  decoration: kInputDecoration('Password')),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: passwordConfirmController,
                  obscureText: true,
                  validator: (val) => val != passwordController.text
                      ? 'Password does not match'
                      : null,
                  decoration: kInputDecoration('Confirm password')),
              SizedBox(
                height: 10,
              ),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : kTextButton('Register', () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = !loading;
                          _registerUser();
                        });
                      }
                    }),
              SizedBox(
                height: 20,
              ),
              kLoginRegisterHint('Do you have account? ', 'Login', () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              })
            ],
          )),
    );
  }
}
