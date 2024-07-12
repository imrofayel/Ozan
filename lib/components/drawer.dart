import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/components/preferences.dart';
import 'package:provider/provider.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool _isEditingUsername = false;
  bool _isEditingApiKey = false;
  late TextEditingController _usernameController;
  late TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _usernameController = TextEditingController(text: appState.userName);
    _apiKeyController = TextEditingController(text: appState.apiKey);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Drawer(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      width: 280,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide(color: Theme.of(context).colorScheme.secondary)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildThemeChanger(context, appState),
                  ],
                ),
                const Gap(16),
                _buildUserNameChanger(context, appState),
                const Gap(16),
                _buildAPIChanger(context, appState),
              ],
            ),
          ),
          _buildAboutContainer(context),
        ],
      ),
    );
  }

  Widget _buildThemeChanger(BuildContext context, AppState appState) {
    return Transform.scale(
      scale: 0.6,
      child: Tooltip(
        message: appState.isDarkMode == true ? 'Light Theme' : 'Dark Theme',
        child: Switch(
          activeColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
          activeTrackColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
          inactiveThumbColor: Colors.blue.shade900.withOpacity(0.7),
          inactiveTrackColor: Colors.transparent,
          value: appState.isDarkMode,
          onChanged: (value) => appState.setDarkMode(value),
        ),
      ),
    );
  }

  Widget _buildUserNameChanger(BuildContext context, AppState appState) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)),
      ),
      padding: const EdgeInsets.only(left: 14, bottom: 2, top: 2, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(
            child: TextField(
              controller: _usernameController,
              enabled: _isEditingUsername,

              style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),

              onEditingComplete: () {
                if (_isEditingUsername) {
                  appState.setUserName(_usernameController.text);
                }
                _isEditingUsername = !_isEditingUsername;
              },

              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.transparent,
                hintText: 'User',
                hoverColor: Colors.transparent,
              ),
            ),
          ),

          const Gap(8),

          IconButton(
            icon: Icon(_isEditingUsername ? CupertinoIcons.arrow_right : CupertinoIcons.pencil,
              color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.7) : Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                size: 21),
            onPressed: () {
              setState(() {
                if (_isEditingUsername) {
                  appState.setUserName(_usernameController.text);
                }
                _isEditingUsername = !_isEditingUsername;
              });
            },
            tooltip: _isEditingUsername ? 'Save' : 'Edit',
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
          )
        ],
      ),
    );
  }

  Widget _buildAPIChanger(BuildContext context, AppState appState) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(
            child: TextField(
              controller: _apiKeyController,
              enabled: _isEditingApiKey,

              obscureText: !_isEditingApiKey,

              obscuringCharacter: '*',
              
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Roboto Mono'),

              onEditingComplete: () {
                if (_isEditingApiKey) {
                  appState.setUserName(_apiKeyController.text);
                }
                _isEditingApiKey = !_isEditingApiKey;
              },

              decoration: InputDecoration(
                prefixIcon: Tooltip(message: 'API Setting', child: Icon(CupertinoIcons.sparkles, size: 23, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
                border: InputBorder.none,
                fillColor: Colors.transparent,
                hintText: 'Google AI API',
                hoverColor: Colors.transparent,
              ),
            ),
          ),

          const Gap(8),

          IconButton(
            icon: Icon(_isEditingApiKey ? CupertinoIcons.arrow_right : CupertinoIcons.pencil,
                color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                size: 21),
            onPressed: () {
                  setState(() {
                    if (_isEditingApiKey) {
                      appState.setApiKey(_apiKeyController.text);
                    }
                    _isEditingApiKey = !_isEditingApiKey;
                  });
            },
            tooltip: _isEditingApiKey ? 'Save' : 'Edit API',
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
          )
        ],
      ),
    );
  }

  Widget _buildAboutContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)),
      ),
      padding: const EdgeInsets.all(10),
      child: Opacity(
        opacity: 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.scribble, color: Theme.of(context).colorScheme.tertiary, size: 26),
                const Text('Ozan', textScaler: TextScaler.linear(1.3)),
              ],
            ),
            const Gap(4),
            const Text('1.4.2 Pre-alpha', textScaler: TextScaler.linear(1.08)),
            const Gap(3),
            Text(
              '© ${DateTime.now().year} Rofayel Labs',
              textScaler: const TextScaler.linear(1.04),
            ),
          ],
        ),
      ),
    );
  }
}