import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ultils/colors.dart';
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text('Dark mode'),
              subtitle: Text(themeProvider.themeMode == ThemeMode.dark ? "On" : "Off"),
              secondary: Icon(
                themeProvider.themeMode == ThemeMode.dark 
                    ? Icons.dark_mode 
                    : Icons.light_mode,
                color: AppColors.yellow,
              ),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (bool value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}