import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/compoments/images_title.dart';
import 'package:login_page/compoments/my_button.dart';
import 'package:login_page/compoments/text_field.dart';
import 'package:login_page/constants/colors.dart';

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  final Function()? onTap;
  loginPage({super.key, required this.onTap});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

//function when User login
  void signInUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  // function wrongEmailMessage()
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: tdGreen,
            title: Center(
              child: Text(
                message ,
                style: const TextStyle(color: tdWhite),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.lock,
                  size: 80,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Welcome to Login',
                  style: TextStyle(
                      color: tdBlack, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                textField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                textField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot password?',
                          style: TextStyle(
                              color: tdBlue,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                myButton(
                  text: 'Sign In',
                  onTap: signInUser,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: tdGray,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: tdBlack),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: tdGray,
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imagesTitle(
                      imagePath: 'assets/images/apple.png',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    imagesTitle(
                      imagePath: 'assets/images/google.png',
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',
                        style: TextStyle(color: tdBlack)),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
