import 'package:flutter/material.dart';
import "../screens/third_welcome.dart";
import '../ultils/colors.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/images/welcome_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), 
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.pink, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFeatureRow("✨", "Log your subscriptions regularly"),
                    const SizedBox(height: 20),
                    _buildFeatureRow("🚀", "No need for manual math; know your expiry dates in a click"),
                  ],
                ),
              ),

              const Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                      backgroundColor: AppColors.pink,
                      foregroundColor: AppColors.blue,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdPage()),
                    ),
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFeatureRow(String emoji, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 23)),
        const SizedBox(width: 17),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.blue,fontWeight: FontWeight.w600, height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}