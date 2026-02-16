import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "../screens/suggestion.dart";
import '../screens/settings.dart';
import'../ultils/colors.dart';

class AddSubscriptionPage extends StatefulWidget {
  const AddSubscriptionPage({super.key});

  @override
  State<AddSubscriptionPage> createState() => _AddSubscriptionPageState();
}

class _AddSubscriptionPageState extends State<AddSubscriptionPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SubscriptionsListPage(),
    const SeggestionsPage(),
    SettingsPage(),
  ];

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
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white.withOpacity(0.8), 
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: AppColors.pink, 
          unselectedItemColor: AppColors.yellow,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'My subscribtions'),
            BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Suggestions'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

class SubscriptionsListPage extends StatefulWidget {
  const SubscriptionsListPage({super.key});

  @override
  State<SubscriptionsListPage> createState() => _SubscriptionsListPageState();
}

class _SubscriptionsListPageState extends State<SubscriptionsListPage> {
  // و بدون تغيير,,,,,,,,,,,,,,,,,,,,,,,,,, 
  final _companyController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedPeriod = 'monthly';

  DateTime _calculateExpiry(String startDate, String period) {
    DateTime start = DateTime.parse(startDate);
    if (period == 'monthly') return DateTime(start.year, start.month + 1, start.day);
    if (period == '6 months') return DateTime(start.year, start.month + 6, start.day);
    if (period == 'yearly') return DateTime(start.year + 1, start.month, start.day);
    return start;
  }

  Future<void> _saveSubscription() async {
    try {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await Supabase.instance.client.from('project').insert({
        'company': _companyController.text.trim(),
        'price': int.parse(_priceController.text.trim()),
        'period': _selectedPeriod,
        'start_date': formattedDate,
      });
      if (mounted) {
        _companyController.clear();
        _priceController.clear();
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add new subscribtion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.pink)),
                TextField(controller: _companyController, decoration: const InputDecoration(labelText: 'Company')),
                TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: _selectedPeriod,
                  isExpanded: true,
                  items: ['monthly', 'yearly', '6 months'].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                  onChanged: (val) => setModalState(() => _selectedPeriod = val!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.pink, foregroundColor: Colors.white),
                  onPressed: _saveSubscription, 
                  child: const Text('حفظ')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      appBar: AppBar(
        title: const Text('My subscriptions', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client.from('project').stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final subs = snapshot.data!;
          return ListView.builder(
            itemCount: subs.length,
            itemBuilder: (context, index) {
              final item = subs[index];
              final expiry = _calculateExpiry(item['start_date'], item['period']);
              return Card(
                color: Colors.white.withOpacity(0.85),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: const Icon(Icons.subscriptions, color: AppColors.pink),
                  title: Text(item['company'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("End at: ${DateFormat('yyyy-MM-dd').format(expiry)}"),
                  trailing: Text("${item['price']} SR", style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSheet,
        backgroundColor: AppColors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}