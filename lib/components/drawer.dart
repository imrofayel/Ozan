// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// class SidebarDrawer extends StatelessWidget {
//   const SidebarDrawer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return Drawer(

//       elevation: 0,      

//       surfaceTintColor: Colors.transparent,

//       shadowColor: Colors.transparent,

//       width: 330,

//       backgroundColor: Theme.of(context).colorScheme.primary,

//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),

//       child: Column(

//         mainAxisAlignment: MainAxisAlignment.spaceBetween,

//         crossAxisAlignment: CrossAxisAlignment.center,

//         children: [

//           const Placeholder(),

//           Container(

//             margin: const EdgeInsets.all(10),

//             decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary.withOpacity(0.4), borderRadius: BorderRadius.circular(8), border: Border.all(color: Theme.of(context).colorScheme.secondary)),

//             padding: const EdgeInsets.all(10),

//             child: Column(
            
//               mainAxisAlignment: MainAxisAlignment.start,
            
//               crossAxisAlignment: CrossAxisAlignment.start,
            
//               children: [
            
//                  const Text('Ozan', textScaler: TextScaler.linear(1.25)),
            
//                  const Gap(4),
            
//                  const Text('1.4.2 Pre-alpha', textScaler: TextScaler.linear(1.08)),
            
//                  const Gap(3),
            
//                  Text('© ${DateTime.now().year} Rofayel Labs. All rights reserved', textScaler: const TextScaler.linear(1)),
//               ],
//             ),
//           ),
//         ],
//       ),
    
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({super.key});

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool _isDarkMode = false;
  String _userName = 'User';
  String _apiKey = '';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
      _userName = _prefs.getString('userName') ?? 'User';
      _apiKey = _prefs.getString('apiKey') ?? '';
    });
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool('isDarkMode', _isDarkMode);
    await _prefs.setString('userName', _userName);
    await _prefs.setString('apiKey', _apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      width: 330,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildThemeSwitcher(),
                const Gap(16),
                _buildUserNameChanger(),
                const Gap(16),
                _buildApiEditor(),
              ],
            ),
          ),
          _buildAboutContainer(),
        ],
      ),
    );
  }

  Widget _buildThemeSwitcher() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode', textScaler: TextScaler.linear(1.2)),
          Switch(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                _saveSettings();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameChanger() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('User Name', textScaler: TextScaler.linear(1.2)),
          const Gap(8),
          TextField(
            controller: TextEditingController(text: _userName),
            onChanged: (value) {
              setState(() {
                _userName = value;
                _saveSettings();
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApiEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('API Key', textScaler: TextScaler.linear(1.2)),
          const Gap(8),
          TextField(
            controller: TextEditingController(text: _apiKey),
            onChanged: (value) {
              setState(() {
                _apiKey = value;
                _saveSettings();
              });
            },
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContainer() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ozan', textScaler: TextScaler.linear(1.25)),
          const Gap(4),
          const Text('1.4.2 Pre-alpha', textScaler: TextScaler.linear(1.08)),
          const Gap(3),
          Text(
            '© ${DateTime.now().year} Rofayel Labs. All rights reserved',
            textScaler: const TextScaler.linear(1),
          ),
        ],
      ),
    );
  }
}

