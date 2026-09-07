import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().userProfile;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(title: const Text('Name'), subtitle: Text(profile.name)),
          ListTile(title: const Text('Goal'), subtitle: Text(profile.goal)),
          ListTile(title: const Text('Level'), subtitle: Text(profile.level)),
          ListTile(
            title: const Text('Height'),
            subtitle: Text('${profile.height.toStringAsFixed(0)} cm'),
          ),
          ListTile(
            title: const Text('Weight'),
            subtitle: Text('${profile.weight.toStringAsFixed(0)} kg'),
          ),
        ],
      ),
    );
  }
}
