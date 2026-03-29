import 'package:flutter/material.dart';
import 'package:gutsyx/core/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _biometric = false;
  bool _appleHealth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSection('Security & Privacy'),
          SwitchListTile(
            title: const Text('Biometric Lock'),
            subtitle: const Text('FaceID or Fingerprint'),
            value: _biometric,
            onChanged: (v) => setState(() => _biometric = v),
            activeColor: AppTheme.electricBlue,
          ),
          _buildSection('Notifications'),
          SwitchListTile(
            title: const Text('Daily Reminders'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
            activeColor: AppTheme.electricBlue,
          ),
          _buildSection('Integrations'),
          SwitchListTile(
            title: const Text('Sync with Health App'),
            subtitle: const Text('Apple Health / Google Fit'),
            value: _appleHealth,
            onChanged: (v) => setState(() => _appleHealth = v),
            activeColor: AppTheme.electricBlue,
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'GutsyX AI v1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
