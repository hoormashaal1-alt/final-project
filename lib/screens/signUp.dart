import 'package:flutter/material.dart';
import '../ultils/colors.dart';
import "../widget/textField.dart";
import '../service/database.dart';
import "../screens/login.dart";
import "../extension/nav.dart";

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});
  @override
  State<signUpPage> createState() => _SigninState();
}

class _SigninState extends State<signUpPage> {
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
                  boxShadow: [
                    BoxShadow(blurRadius: 10, color: AppColors.green),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.blue),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          try {
                            await Database().signUp(
                              email: emailController.text,
                              password: passWordController.text,
                            );
                            if (mounted) context.push(LoginPage());
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                          }
                        },
                        child: const Text("Create Account", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    TextButton(
                      onPressed: () => context.pushAndDelete(LoginPage()),
                      child: const Text("Already have an account? Log in"),
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