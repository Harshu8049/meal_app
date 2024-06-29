import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/controller/controller.dart';
import 'package:meal_app/hive/hive.dart';
import 'package:meal_app/screen/login_page.dart/login_page.dart';
import 'package:meal_app/screen/registerform.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginPageController controller = Get.put(LoginPageController());

  @override
  void initState() {
    super.initState();
    List<dynamic> x = box.get('IDPassword') ?? [];
    List<Map<String, String>> storedLoginIdPasswords = [];
    for (var element in x) {
      if (element is Map) {
        var email = element['EmailID'];
        var password = element['password'];
        if (email is String && password is String) {
          Map<String, String> loginData = {
            'EmailID': email,
            'password': password,
          };
          storedLoginIdPasswords.add(loginData);
        }
      }
    }
    controller.storedLoginIdPasswords = storedLoginIdPasswords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RegisterForm(controller: controller),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.orange),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final formKey = controller.registerformkey;
                          if (formKey.currentState!.validate()) {
                            if (controller.storedLoginIdPasswords.any((id) =>
                                id['EmailID'] ==
                                controller.registerpageemailcontrolller.text)) {
                              Get.closeAllSnackbars();
                              Get.snackbar(
                                  'Already Exist', 'Use another email address',
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              controller.storedLoginIdPasswords.add({
                                'EmailID': controller
                                    .registerpageemailcontrolller.text,
                                'password': controller
                                    .registerpagepasswordcontroller.text,
                              });

                              box.put('IDPassword',
                                  controller.storedLoginIdPasswords);

                              Get.closeAllSnackbars();
                              Get.snackbar(
                                duration: const Duration(seconds: 2),
                                snackPosition: SnackPosition.BOTTOM,
                                'Success',
                                'Registered successfully',
                              );
                              Get.to(() => const LogininScreen());

                              controller.registerpageemailcontrolller.clear();
                              controller.registerpagepasswordcontroller.clear();
                              controller.update();
                            }
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LogininScreen());
                          controller.registerpageemailcontrolller.clear();
                          controller.registerpagepasswordcontroller.clear();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
