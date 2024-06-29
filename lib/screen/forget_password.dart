
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _otpSent = false;
  bool _verifying = false;
  bool _otpVerified = false;
  String _verificationId = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval scenario
          await _auth.signInWithCredential(credential);
          setState(() {
            _otpVerified = true;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', e.message ?? 'Verification failed',
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void verifyOTP() async {
    setState(() {
      _verifying = true;
    });
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);
      setState(() {
        _otpVerified = true;
      });

      Get.snackbar('OTP Verified', 'You can now reset your password',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP', snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() {
        _verifying = false;
      });
    }
  }

  void resetPassword() async {
    try {
      await _auth.currentUser!.updatePassword(_newPasswordController.text);
      Get.snackbar('Success', 'Password reset successful',
          snackPosition: SnackPosition.BOTTOM);
      // Navigate back to login screen or perform other actions
    } catch (e) {
      Get.snackbar('Error', 'Password reset failed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Enter Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (!_otpSent)
                ElevatedButton(
                  onPressed: sendOTP,
                  child: const Text('Send OTP'),
                ),
              if (_otpSent && !_otpVerified)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter OTP',
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter OTP';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (!_verifying)
                      ElevatedButton(
                        onPressed: verifyOTP,
                        child: const Text('Verify OTP'),
                      )
                    else
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              if (_otpVerified)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        labelText: 'Enter New Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a new password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resetPassword,
                      child: const Text('Reset Password'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
