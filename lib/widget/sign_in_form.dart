import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yearmap/model/firebase_auth_state.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세용~';
                  }
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 2) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호 입력해주세용~';
                  }
                },
              ),
              FlatButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgotten Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              _submitButton(context),
              SizedBox(
                height: 10.0,
              ),
              //OrDivider(),
              FlatButton.icon(
                  onPressed: () {
                    Provider.of<FirebaseAuthState>(context, listen: false)
                        .loginWithFacebook(context);
                  },
                  textColor: Colors.blue,
                  icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                  label: Text("Login with Facebook"))
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textInputDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: activeInputBorder(),
        focusedBorder: activeInputBorder(),
        errorBorder: errorInputBorder(),
        focusedErrorBorder: errorInputBorder(),
        filled: true,
        fillColor: Colors.grey[100]);
  }

  OutlineInputBorder errorInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.circular(10.0));
  }

  OutlineInputBorder activeInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[300],
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('Validation success!!');

          Provider.of<FirebaseAuthState>(context, listen: false).login(context,
              email: _emailController.text, password: _pwController.text);
        }
      },
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
