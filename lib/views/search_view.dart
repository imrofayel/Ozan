import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ozan/db/db_handler.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:ozan/views/update_view.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DBHelper dbHelper = DBHelper();
  final TextEditingController searchController = TextEditingController();
  Map<String, List<NotesModel>> searchResults = {'title': [], 'description': []};

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (searchController.text.isEmpty) {
      setState(() {
        searchResults = {'title': [], 'description': []};
      });
    } else {
      _performSearch(searchController.text);
    }
  }

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = {'title': [], 'description': []};
      });
      return;
    }

    final results = await dbHelper.searchNotes(query);
    if (mounted) {
      setState(() {
        searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: TextField(

                    maxLines: 1,
                    controller: searchController,
                    decoration: InputDecoration(

                      constraints: BoxConstraints.tight(const Size(500, 100)),

                      contentPadding: const EdgeInsets.all(20),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 6),
                        child: Icon(LucideIcons.search, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)),
                      ),
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),

                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)), borderRadius: BorderRadius.circular(100)),

                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)), borderRadius: BorderRadius.circular(100)),

                      hoverColor: Colors.transparent


                    ),

                    style: const TextStyle(fontSize: 19),

                    cursorHeight: 30,

                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      ..._buildSearchResults('Title Matches', searchResults['title']!),
                  
                      const Gap(20),
                      
                      ..._buildSearchResults('Description Matches', searchResults['description']!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSearchResults(String title, List<NotesModel> notes) {
    return [
      ...notes.map((note) => ListTile(
        title: Text(note.title),
        onTap: () {
          Provider.of<Navigation>(context, listen: false).getPage(Update(note: note));
        },
      )),
    ];
  }
}