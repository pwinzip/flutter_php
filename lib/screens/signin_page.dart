import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_php/utils/style.dart';
import 'package:http/http.dart' as http;

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String user;
  String pass;
  String response = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            // color: Color.fromRGBO(15, 76, 129, 1),
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.yellow[200],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyStyle.showLogo(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        signinForm(
                            context, Icons.account_circle, 'Username', 0),
                        signinForm(context, Icons.lock, 'Password', 1),
                        errField(),
                        submitBtn(),
                        registerBtn(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container errField() {
    return Container(
      padding: EdgeInsets.only(bottom: 6),
      child: Text(
        response,
        style: TextStyle(
          color: MyStyle.errColor,
        ),
      ),
    );
  }

  Future checkLogin() async {
    var strdata = jsonEncode({'user': user, 'pass': pass});
    // var strdata = {'user': user, 'pass': pass}; // for post method
    var url = 'http://127.0.0.1/flutter_php/checkuser.php?data=' + strdata;
    // ใช้ IP ของเครื่อง แทน localhost

    var result = await http.get(url);
    print(jsonDecode(result.body));
    // print(jsonDecode(result.body));
    if (jsonDecode(result.body) == 0) {
      setState(() {
        this.response = 'Invalid Username and Password';
      });
    } else {
      setState(() {
        this.response = '';
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      });
    }
  }

  Container registerBtn() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              color: MyStyle.secondaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: GestureDetector(
              onTap: () {
                print('Register Tap');
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container submitBtn() {
    return Container(
      width: 240,
      height: 40,
      child: RaisedButton(
        color: Colors.white,
        textColor: MyStyle.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            color: MyStyle.secondaryColor,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            checkLogin();
            print(user + " " + pass);
          } else {
            print('false');
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Container signinForm(
      BuildContext context, IconData icon, String label, int flag) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 250,
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        validator: (value) {
          if (value.isEmpty)
            return 'Please Enter ' + (flag == 0 ? 'Username' : 'Password');
          return null;
        },
        onSaved: (newValue) {},
        onChanged: (value) {
          setState(() {
            flag == 0 ? user = value : pass = value;
          });
        },
        obscureText: flag == 1 ? true : false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: MyStyle.secondaryColor,
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: MyStyle.secondaryColor,
          ),
          errorStyle: TextStyle(
            color: MyStyle.errColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyStyle.secondaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyStyle.secondaryColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(255, 111, 97, 1),
            ),
          ),
        ),
      ),
    );
  }
}
