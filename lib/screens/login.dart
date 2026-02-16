import 'package:flutter/material.dart';
import '../ultils/colors.dart';
import "../widget/textField.dart";
import '../service/database.dart';
import "../extension/nav.dart";
import"../screens/signUp.dart";
import"../screens/screen.dart";
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/welcome_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black26),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue),
                    ),
                    const SizedBox(height: 30),
                    TextField_wedget(
                      controller: emailController,
                      hint: "Email",
                      icon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 15),
                    TextField_wedget(
                      controller: passWordController,
                      hint: "Password",
                      icon: const Icon(Icons.lock),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await Database().login(
                              email: emailController.text,
                              password: passWordController.text,
                            );

                            if (context.mounted) {
                              context.push(AddSubscriptionPage());
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushAndDelete(signUpPage());
                      },
                      child: const Text("don't have an account? sign up"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}