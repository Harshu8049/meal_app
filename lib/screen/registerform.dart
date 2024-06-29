import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/controller/controller.dart';

class RegisterForm extends StatelessWidget {
  final LoginPageController controller;

  const RegisterForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registerformkey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width - 20,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: controller.registerpageemailcontrolller,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: "Email Address",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email address is not valid';
                } else if (!value.contains("@")) {
                  return 'Email address is not valid';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width - 20,
            child: GetBuilder<LoginPageController>(
              builder: (_) {
                return TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: controller.registerpagepasswordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.black,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.registerobscureText =
                            !controller.registerobscureText;
                        controller.update();
                      },
                      icon: Icon(
                        controller.registerobscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  obscureText: controller.registerobscureText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please choose a strong password";
                    } else {
                      return null;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
