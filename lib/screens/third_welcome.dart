
import 'package:flutter/material.dart';
import '../ultils/colors.dart'; 
import"../screens/login.dart";
import"../screens/signUP.dart";
class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
     image:DecorationImage(image: AssetImage("lib/assets/images/welcome_bg.jpg"),fit: BoxFit.cover
     )
    ),child: Scaffold(backgroundColor:  Colors.transparent,body:SizedBox(width:double.infinity, 
    
    child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [Spacer(),
      Center(
    
    
    child: Text("chose now"
      ,style: TextStyle(
                    fontSize: 30,
                    color: AppColors.darkBlue, 
                    fontWeight: FontWeight.bold,
                  )
    
    
    
    ,),
          ),ElevatedButton(
           onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => signUp(),)),
            child: Text("Sign in"),),ElevatedButton(
           onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(),)),
            child: Text("Log in   ")),Spacer(),Padding(
        padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
         
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
          
         
    
          
        ],
      ),
    ),
  ],
    ),)));}
}