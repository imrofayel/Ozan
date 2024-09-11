import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ozan/providers/preferences.dart';
import 'package:ozan/theme/theme_provider.dart';
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
    final appState = Provider.of<AppState>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Settings', style: TextStyle(fontSize: 22)),
              const Gap(20),

              _buildUserNameChanger(context, appState),
              const Gap(20),
              _buildAPIChanger(context, appState),
              const Gap(20),

              _buildFontChanger(context, appState),
              
              Opacity(opacity: 0.9, child: _buildAboutContainer(context)),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildFontChanger(context, AppState appState) {

  String selectedFont = Provider.of<AppState>(context, listen: false).fontFamily;

  List<DropdownMenuEntry<dynamic>> dropdownMenuEntries = [
    const DropdownMenuEntry(
      value: 'Roboto', 
      label: 'Roboto',
      style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(fontFamily: 'Roboto'))),
    ),
    const DropdownMenuEntry(
      value: 'Inter', 
      label: 'Inter',
      style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(fontFamily: 'Inter'))),
    ),
    const DropdownMenuEntry(
      value: 'Lora', 
      label: 'Lora',
      style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(fontFamily: 'Lora'))), // Apply Lora style
    ),
  ];

  return DropdownMenu(
    initialSelection: selectedFont,
    dropdownMenuEntries: dropdownMenuEntries,
    onSelected: (font) {
        Provider.of<ThemeAndFontProvider>(context, listen: false).setFontFamily(font, context);
    },
    textStyle: const TextStyle(), // Default style for the menu itself
  );
}

  Widget _buildUserNameChanger(BuildContext context, AppState appState) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.only(left: 4, bottom: 2, top: 2, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
                controller: _usernameController,
                enabled: _isEditingUsername,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.9),
                    fontSize: 18),
                onEditingComplete: () {
                  if (_isEditingUsername) {
                    appState.setUserName(_usernameController.text);
                  }
                  _isEditingUsername = !_isEditingUsername;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    hintText: 'Username',
                    hoverColor: Colors.transparent,
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.6),
                        fontSize: 8,
                        fontFamily: 'Roboto Mono'),
                    prefixIcon: Icon(LucideIcons.user2,
                        size: 21,
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.9)))),
          ),
          const Gap(8),
          IconButton(
            icon: Icon(
                _isEditingUsername
                    ? LucideIcons.arrowRight
                    : CupertinoIcons.pencil,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
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
            hoverColor: Theme.of(context).colorScheme.primary,
            style: ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1))),
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
          )
        ],
      ),
    );
  }

  Widget _buildAPIChanger(BuildContext context, AppState appState) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.only(left: 4, bottom: 2, top: 2, right: 4),
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
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                  fontSize: 18),
              onEditingComplete: () {
                if (_isEditingApiKey) {
                  appState.setUserName(_apiKeyController.text);
                }
                _isEditingApiKey = !_isEditingApiKey;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintText: 'Google API Key',
                  hoverColor: Colors.transparent,
                  hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.6),
                      fontSize: 18),
                  prefixIcon: Tooltip(
                      message: 'API',
                      child: Icon(LucideIcons.sparkle,
                          size: 21,
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.9)))),
            ),
          ),
          const Gap(8),
          IconButton(
            icon: Icon(
                _isEditingApiKey
                    ? LucideIcons.arrowRight
                    : CupertinoIcons.pencil,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
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
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            style: ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1))),
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
          )
        ],
      ),
    );
  }

  Widget _buildAboutContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.scribble,
                  color: Theme.of(context).colorScheme.tertiary, size: 30),
              const Text('Ozan 1.0.6', textScaler: TextScaler.linear(1.4)),
            ],
          ),
          const Gap(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                getButton(context, 'Markdown Support', LucideIcons.textCursor),
                const Gap(10),
                getButton(
                    context, 'LaTex & Syntax Highlighting', LucideIcons.code2),
                const Gap(10),
                getButton(context, 'Graph', LucideIcons.gitCompare),
                const Gap(10),
                getButton(context, 'AI Copilot', LucideIcons.sparkle),
                const Gap(10),
                getButton(context, 'Offline', LucideIcons.partyPopper),
                const Gap(10),
                getButton(context, 'Import/Export', LucideIcons.file),
              ],
            ),
          ),

          const Gap(20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                getButton(context, 'Developed by Naveed Azhar', LucideIcons.user2),

                const Gap(10),

                getButton(context, 'imrofayel', LucideIcons.github),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getButton(context, String title, IconData icon) {
  return FilledButton(
    onPressed: () {},
    style: ButtonStyle(
      side: MaterialStatePropertyAll(BorderSide(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
      backgroundColor:
          MaterialStatePropertyAll(Theme.of(context).colorScheme.background),
    ),
    child: Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.tertiary, size: 19),
        const Gap(8),
        Text(title,
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.tertiary)),
      ],
    ),
  );
}
