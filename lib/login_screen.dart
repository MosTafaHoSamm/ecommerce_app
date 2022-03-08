import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Text('Login'),

          ),
          TextFormField(
            decoration: InputDecoration(
          label: Text('Email')
          )
            ),
          TextFormField(
            decoration: InputDecoration(
          label: Text('password')
          )
            ),

        ],
      ),
    );
  }
}
