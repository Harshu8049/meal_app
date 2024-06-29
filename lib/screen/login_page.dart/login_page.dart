import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/controller/controller.dart';
import 'package:meal_app/hive/hive.dart';
import 'package:meal_app/screen/forget_password.dart';
import 'package:meal_app/screen/register_page.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:meal_app/screen/tabs.dart';

class LogininScreen extends StatefulWidget {
  const LogininScreen({Key? key}) : super(key: key);

  @override
  _LogininScreenState createState() => _LogininScreenState();
}

class _LogininScreenState extends State<LogininScreen>
    with SingleTickerProviderStateMixin {
  final LoginPageController controller = Get.put(LoginPageController());
  final formkey = GlobalKey<FormState>();
  Color boxcolor = Colors.orange;
  bool isPlaying = false;
  final confetticontroller =
      ConfettiController(duration: const Duration(milliseconds: 200));

  bool obscureText = true;
  Text buttonText = const Text(
    'Login',
    style: TextStyle(color: Colors.white),
  );

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    confetticontroller.addListener(() {
      isPlaying = confetticontroller.state == ConfettiControllerState.playing;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    confetticontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = context.height;
    double screenWidth = context.width;

    return GetBuilder<LoginPageController>(builder: (_) {
      void passwordEye() {
        controller.loginobscureText = !controller.loginobscureText;
        controller.update();
      }

      void goToForgotPassword() {
        Get.to(() => ForgotPasswordScreen());
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07),
                        const Text(
                          "Log-In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller:
                                        controller.loginpageemailcontrolller,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.black,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        labelText: "Email Address",
                                        labelStyle:
                                            TextStyle(color: Colors.grey)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email address is not valid';
                                      } else if (!value.contains("@")) {
                                        return 'Email address is not valid';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller:
                                        controller.loginpagepasswordcontroller,
                                    keyboardType: TextInputType.visiblePassword,
                                    cursorColor: Colors.black,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                        labelText: "Password",
                                        labelStyle:
                                            const TextStyle(color: Colors.grey),
                                        suffixIcon: IconButton(
                                            onPressed: passwordEye,
                                            icon: Icon(
                                              controller.loginobscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black54,
                                            ))),
                                    obscureText: controller.loginobscureText,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please choose a strong password";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 50,
                            child: LoadingBtn(
                              borderRadius: 24,
                              roundLoadingShape: false,
                              loader: AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Transform(
                                    transform: Matrix4.identity()
                                      ..rotateX(
                                          _animationController.value * 2 * pi),
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              height: 50,
                              width: Get.width - 40,
                              animate: true,
                              color: boxcolor,
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                FocusScope.of(context).unfocus();
                                if (btnState == ButtonState.idle) {
                                  if (formkey.currentState!.validate()) {
                                    startLoading();
                                    _animationController.repeat();
                                    setState(() {
                                      boxcolor = const Color.fromARGB(
                                          255, 241, 195, 128);
                                    });
                                  }

                                  await Future.delayed(
                                      const Duration(seconds: 5));
                                  _animationController.stop();
                                  _animationController.reset();
                                  setState(() {
                                    boxcolor = Colors.orange;
                                  });
                                  stopLoading();

                                  if (formkey.currentState!.validate()) {
                                    if (controller.storedLoginIdPasswords.any(
                                        (id) =>
                                            id['EmailID'] ==
                                                controller
                                                    .loginpageemailcontrolller
                                                    .text &&
                                            id['password'] ==
                                                controller
                                                    .loginpagepasswordcontroller
                                                    .text)) {
                                      if (controller
                                              .loginpageemailcontrolller.text ==
                                          'test1@gmail.com') {
                                        setState(() {
                                          boxcolor = Colors.green;
                                          buttonText = const Text(
                                            'Authenticate Success',
                                            style:
                                                TextStyle(color: Colors.white),
                                          );
                                        });

                                        await Future.delayed(
                                            const Duration(microseconds: 500));

                                        confetticontroller.play();
                                        await Future.delayed(
                                            const Duration(seconds: 2));

                                        Get.to(() => const TabsScreen());
                                        setState(() {
                                          boxcolor = Colors.orange;
                                          buttonText = const Text(
                                            'Login',
                                            style:
                                                TextStyle(color: Colors.white),
                                          );
                                        });
                                        confetticontroller.stop();

                                        box1.put(
                                            'DataUser1', controller.dataUser1);
                                      } else if (controller
                                              .loginpageemailcontrolller.text ==
                                          'test2@gmail.com') {
                                        setState(() {
                                          boxcolor = Colors.green;
                                          buttonText = const Text(
                                            'Authenticate Success',
                                            style:
                                                TextStyle(color: Colors.white),
                                          );
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                        Get.to(() => const TabsScreen());
                                        box1.put(
                                            'DataUser2', controller.dataUser2);
                                      } else {
                                        setState(() {
                                          boxcolor = Colors.green;
                                          buttonText = const Text(
                                            'Authenticate Success',
                                            style:
                                                TextStyle(color: Colors.white),
                                          );
                                        });
                                        Future.delayed(
                                            const Duration(seconds: 2));
                                        Get.to(() => const TabsScreen());

                                        box1.put('Data', controller.data);
                                      }

                                      Get.closeAllSnackbars();
                                      Get.snackbar(
                                          snackPosition: SnackPosition.BOTTOM,
                                          'Success',
                                          'login successfully');
                                    } else {
                                      Get.snackbar(
                                          snackPosition: SnackPosition.BOTTOM,
                                          'Incorrect',
                                          'Enter Valid Email Address or password');
                                    }
                                  }
                                }
                              },
                              child: buttonText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            const Text(
                              "New User? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const RegisterScreen());
                                controller.loginpageemailcontrolller.clear();
                                controller.loginpagepasswordcontroller.clear();
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.blue),
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
          ),
          ConfettiWidget(
            canvas: Size(Get.width, Get.height),
            particleDrag: 0.2,
            confettiController: confetticontroller,
            shouldLoop: false,
            blastDirectionality: BlastDirectionality.explosive,
            blastDirection: pi * 2,
            numberOfParticles: 10,
            minBlastForce: 500,
            maxBlastForce: 1000,
            emissionFrequency: 0.80,
            displayTarget: false,
            colors: const [
              Colors.green,
              Color.fromARGB(255, 118, 183, 236),
              Color.fromARGB(255, 227, 180, 163),
              Color.fromARGB(255, 235, 137, 130),
              Color.fromARGB(255, 229, 185, 119),
              Color.fromARGB(255, 124, 222, 227),
              Color.fromARGB(255, 250, 145, 233),
              Color.fromARGB(255, 190, 144, 240),
              Color.fromARGB(238, 217, 72, 200),
              Color.fromARGB(255, 208, 80, 60),
            ],
            gravity: 0.8,
            createParticlePath: (size) {
              final path = Path();
              path.addOval(Rect.fromCircle(center: Offset.zero, radius: 7));
              return path;
            },
          ),
        ],
      );
    });
  }
}
