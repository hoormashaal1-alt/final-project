import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/model_subscription.dart'; 
import '../ultils/colors.dart';
class SeggestionsPage extends StatelessWidget {
  const SeggestionsPage({super.key});

  Future<List<Subscription>> loadSuggestions() async {
    final String response = await rootBundle.loadString('lib/assets/data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Subscription.fromAssetJson(json)).toList();
  }

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
        appBar: AppBar(
          title: const Text('Suggestions', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder<List<Subscription>>(
          future: loadSuggestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColors.green));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No suggestions found", style: TextStyle(color: Colors.white)));
            }

            final suggestions = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final item = suggestions[index];
                return Card(
                  color: Colors.white.withOpacity(0.9),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: AppColors.yellow, width: 1),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.yellow,
                      child: Icon(Icons.star, color:AppColors.green ),
                    ),
                    title: Text(
                      item.company ?? "Unknown",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      "${item.period} plan",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Text(
                      "${item.price} SR",
                      style: const TextStyle(
                        color: AppColors.green, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 16
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}