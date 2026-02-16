import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart'; // 1. أضفنا مكتبة البروفايدر
import 'screens/settings.dart';
import"../screens/first_welcome.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://xnqlyrmxjpyzchycjvsu.supabase.co",
    anonKey: "sb_publishable_fjU09vN3tMCnFtuR850ZUg_5RCxjp4c",
  );

  // 2. تغليف التطبيق بالـ Provider
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. استدعاء حالة الثيم الحالية
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 4. ربط وضع الثيم بالتطبيق
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode, 
      home: StartPage(), // كما هو في كودك الأصلي
    );
  }
}