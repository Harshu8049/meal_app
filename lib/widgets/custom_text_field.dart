import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}
