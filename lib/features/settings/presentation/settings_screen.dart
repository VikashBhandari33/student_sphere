import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/auth/presentation/auth_controller.dart';
import 'package:student_sphere/core/theme/theme_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          if (user != null)
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                child: Text(user.displayName.isNotEmpty
                    ? user.displayName[0].toUpperCase()
                    : 'U'),
              ),
            ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: ref.watch(themeControllerProvider) == ThemeMode.dark,
              onChanged: (value) {
                ref.read(themeControllerProvider.notifier).toggleTheme(value);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // TODO: Notification Settings
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              ref.read(authControllerProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
