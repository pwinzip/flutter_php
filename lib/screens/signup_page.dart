import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_php/utils/style.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _registerKey = GlobalKey<FormState>();
  String name, tel, user, pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyStyle.showLogo(),
              Form(
                key: _registerKey,
                child: Column(
                  children: [
                    inputName(),
                    inputTel(),
                    inputUsername(),
                    inputPassword(),
                    submitBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container inputName() {
    return Container(
      padding: EdgeInsets.all(8),
      width: 250,
      child: TextFormField(
        style: TextStyle(
          color: MyStyle.primaryColor,
        ),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter some text.';
          return null;
        },
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      ),
    );
  }

  Container inputTel() {
    return Container(
      padding: EdgeInsets.all(8),
      width: 250,
      child: TextFormField(
        style: TextStyle(
          color: MyStyle.primaryColor,
        ),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter some text.';
          return null;
        },
        onChanged: (value) {
          setState(() {
            tel = value;
          });
        },
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: 'Telephone',
        ),
      ),
    );
  }

  Container inputUsername() {
    return Container(
      padding: EdgeInsets.all(8),
      width: 250,
      child: TextFormField(
        style: TextStyle(
          color: MyStyle.primaryColor,
        ),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter some text.';
          return null;
        },
        onChanged: (value) {
          setState(() {
            user = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Username',
        ),
      ),
    );
  }

  Container inputPassword() {
    return Container(
      padding: EdgeInsets.all(8),
      width: 250,
      child: TextFormField(
        obscureText: true,
        style: TextStyle(
          color: MyStyle.primaryColor,
        ),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter some text.';
          return null;
        },
        onChanged: (value) {
          setState(() {
            pass = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Password',
        ),
      ),
    );
  }

  Container submitBtn() {
    return Container(
      margin: EdgeInsets.all(16),
      width: 240,
      height: 40,
      child: RaisedButton(
        color: MyStyle.primaryColor,
        textColor: MyStyle.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            color: MyStyle.primaryColor,
          ),
        ),
        onPressed: () {
          if (_registerKey.currentState.validate()) {
            print(name + " " + tel + " " + user + " " + pass);
            registerUser();
          } else {
            print('false');
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Future<void> registerUser() async {
    var strdata = jsonEncode({
      'name': name,
      'tel': tel,
      'user': user,
      'pass': pass,
    });
    var url = 'http://127.0.0.1/api/register.php?data=' + strdata;
    var result = await http.get(url);

    if (jsonDecode(result.body) == '1') {
      print(jsonDecode(result.body));
      Navigator.pop(context);
    } else {
      print(result.body);
    }
  }
}
