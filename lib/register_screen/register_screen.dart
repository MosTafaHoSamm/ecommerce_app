import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Text('Register'),

          ),
          TextFormField(
            decoration: InputDecoration(
          label: Text('Email'),
          )
            ),
          TextFormField(
            decoration: InputDecoration(
          label: Text('password'),
              border: OutlineInputBorder(),
          )
            ),
          OutlineButton(onPressed: (){}),

        ],
      ),
    );
  }
}
