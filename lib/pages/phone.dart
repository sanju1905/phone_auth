import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_auth/pages/otp.dart';
import 'package:phone_auth/pages/home.dart'; // Import your home page

class Phone extends StatefulWidget {
  const Phone({Key? key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefix: Text('+91 '),
                hintText: "Enter the Number",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              try {
                final isValidPhoneNumber =
                    await validatePhoneNumber(phoneController.text.trim());
                if (!isValidPhoneNumber) {
                  // Display a snackbar for invalid phone number
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Invalid phone number. Please try again."),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  final exists = await checkIfPhoneNumberExists(
                      phoneController.text.trim());
                  if (exists) {
                    // If phone number already exists, navigate to home page directly
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else {
                    // If phone number doesn't exist, proceed with phone verification
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {
                        print("Verification failed: ${ex.message}");
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Otp(verificationId: verificationId),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: '+91' + phoneController.text.trim(),
                    );
                  }
                }
              } catch (ex) {
                print("Error during phone verification: $ex");
              }
            },
            child: Text("Verify the Phone Number"),
          )
        ],
      ),
    );
  }

  Future<bool> validatePhoneNumber(String phoneNumber) async {
    return phoneNumber.length == 10 && int.tryParse(phoneNumber) != null;
  }

  Future<bool> checkIfPhoneNumberExists(String phoneNumber) async {
    return false;
  }
}
