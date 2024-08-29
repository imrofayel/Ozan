import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/providers/preferences.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool _isEditingUsername = false;
  bool _isEditingApiKey = false;
  late TextEditingController _usernameController;
  late TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: Provider.of<AppState>(context, listen: false).userName);
    _apiKeyController = TextEditingController(text: Provider.of<AppState>(context, listen: false).userName);
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        _buildUserNameChanger(context),

        _buildAPIChanger(context),

        _buildThemeChanger(context),

        _buildAboutContainer(context)
      ],
    );
  }

    Widget _buildThemeChanger(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: Tooltip(
        message: Provider.of<AppState>(context, listen: false).isDarkMode == true ? 'Light Theme' : 'Dark Theme',
        child: Switch(
          activeColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
          activeTrackColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
          inactiveThumbColor: Colors.blue.shade900.withOpacity(0.9),
          inactiveTrackColor: Colors.transparent,
          value: Provider.of<AppState>(context, listen: false).isDarkMode,
          onChanged: (value) => Provider.of<AppState>(context, listen: false).setDarkMode(value),
        ),
      ),
    );
  }

  Widget _buildUserNameChanger(BuildContext context) {
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

              style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)),

              onEditingComplete: () {
                if (_isEditingUsername) {
                  Provider.of<AppState>(context, listen: false).setUserName(_usernameController.text);
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
              color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
                size: 21),
            onPressed: () {
              setState(() {
                if (_isEditingUsername) {
                  Provider.of<AppState>(context, listen: false).setUserName(_usernameController.text);
                }
                _isEditingUsername = !_isEditingUsername;
              });
            },
            tooltip: _isEditingUsername ? 'Save' : 'Edit',
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
          )
        ],
      ),
    );
  }

  Widget _buildAPIChanger(BuildContext context) {
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
              
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), fontFamily: 'Roboto Mono'),

              onEditingComplete: () {
                if (_isEditingApiKey) {
                  Provider.of<AppState>(context, listen: false).setUserName(_apiKeyController.text);
                }
                _isEditingApiKey = !_isEditingApiKey;
              },

              decoration: InputDecoration(
                prefixIcon: Tooltip(message: 'API Setting', child: Icon(CupertinoIcons.sparkles, size: 23, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),
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
                color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
                size: 21),
            onPressed: () {
                  setState(() {
                    if (_isEditingApiKey) {
                      Provider.of<AppState>(context, listen: false).setApiKey(_apiKeyController.text);
                    }
                    _isEditingApiKey = !_isEditingApiKey;
                  });
            },
            tooltip: _isEditingApiKey ? 'Save' : 'Edit API',
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
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