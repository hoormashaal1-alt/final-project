import 'package:flutter/material.dart';

class TextField_wedget extends StatelessWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;

  const TextField_wedget({super.key,required this.hint,
  required this.icon,required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
     controller: controller, decoration: InputDecoration(
     border: OutlineInputBorder(

      borderRadius: BorderRadius.circular(90)
     ),
    prefixIcon: icon,hintText:hint
     ),









    )
    
    
    
    ;
  }
}