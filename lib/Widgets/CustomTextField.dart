import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final bool obstext;
  TextEditingController data= TextEditingController();
  CustomTextField({
    this.label,this.obstext,
    this.data
  }) ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: data,
      obscureText: obstext,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(fontSize: 10.0),
      ),
      style: TextStyle(fontSize: 14.0),
    );
  }
}
