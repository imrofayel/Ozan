import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/files/file_service.dart';
import 'package:ozan/markdown/markdown_styling.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:ozan/views/notes_view.dart';
import 'package:provider/provider.dart';

class Markdown extends StatefulWidget {
  const Markdown({super.key});

  static FileService files =
      FileService(_MarkdownState.page, _MarkdownState.pageTitle);

  @override
  State<Markdown> createState() => _MarkdownState();
}

class _MarkdownState extends State<Markdown> {
  static TextEditingController page = TextEditingController();
  static TextEditingController pageTitle = TextEditingController();
  static final FocusNode _focusNode = FocusNode();

  bool isCodeView = true;
  bool enableTitle = true;
  bool titleExists = false;

  @override
  void initState() {
    super.initState();
    page.addListener(_pageListener);
    pageTitle.addListener(_pageTitleListener);
  }

  void _pageListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _pageTitleListener() {
    if (mounted) {
      _checkTitleExists();
    }
  }

  Future<void> _checkTitleExists() async {
    if (!mounted) return;
    final dbHelper =
        Provider.of<DatabaseProvider>(context, listen: false).dbHelper;
    final existingNotes = await dbHelper.getNotesList();
    if (mounted) {
      setState(() {
        titleExists = existingNotes.any((note) => note.title == pageTitle.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('d MMM, yy').format(DateTime.now());

    return Consumer<DatabaseProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primary),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: TextField(
                controller: pageTitle,
                enabled: enableTitle,
                decoration: InputDecoration(
                    hintText: "Untitled",
                    hintStyle:
                        TextStyle(color: Theme.of(context).colorScheme.tertiary),
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    border: InputBorder.none),
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).colorScheme.tertiary),
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                  child: FilledButton(
                      onPressed: () {
                        if (page.text.isNotEmpty) {
                          if (titleExists) {
                            SnackBarUtils.showSnackbar(
                                context,
                                CupertinoIcons.exclamationmark_circle,
                                "A note with this title already exists.");
                            return;
                          }
                          value.dbHelper.insert(NotesModel(
                            title: pageTitle.text.isNotEmpty
                                ? pageTitle.text
                                : 'Untitled',
                            description: page.text,
                            date: date,
                            favourite: 0,
                            tag: _EditorState.selected.name,
                          ));
                          value.initDatabase();
                          value.setLength();

                          Provider.of<Navigation>(context, listen: false)
                              .getPage(const NotesView());

                          Markdown.files.newFile(context);
                        } else {
                          SnackBarUtils.showSnackbar(
                              context,
                              CupertinoIcons.pencil_slash,
                              "Please enter title and description");
                        }
                      },
                      style: ButtonStyle(
                          side: MaterialStatePropertyAll(BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.1))),
                          padding:
                              const MaterialStatePropertyAll(EdgeInsets.all(14)),
                          overlayColor:
                              const MaterialStatePropertyAll(Colors.transparent),
                          shadowColor:
                              const MaterialStatePropertyAll(Colors.transparent),
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.background)),
                      child: Text('Save',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Inter'))),
                ),
              ],
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Column(
                      children: [
                        ToggleButtons(
                          constraints:
                              const BoxConstraints(minWidth: 50, minHeight: 35),
                          isSelected: [isCodeView, !isCodeView],
                          onPressed: (int index) {
                            setState(() {
                              isCodeView = index == 0;
                              enableTitle = isCodeView;
                            });
                          },
                          fillColor: Theme.of(context).colorScheme.background,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          selectedBorderColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.1),
                          borderColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: isCodeView
                                  ? Row(
                                      children: [
                                        Icon(LucideIcons.check,
                                            size: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                        const Gap(6),
                                        Text('Code',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontFamily: 'Inter')),
                                      ],
                                    )
                                  : Text('Code',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontFamily: 'Inter')),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: !isCodeView
                                  ? Row(
                                      children: [
                                        Icon(LucideIcons.check,
                                            size: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                        const Gap(6),
                                        Text('Preview',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontFamily: 'Inter')),
                                      ],
                                    )
                                  : Text('Preview',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontFamily: 'Inter')),
                            ),
                          ],
                        ),
                        Expanded(
                          child:
                              isCodeView ? const Editor() : preview(context),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget preview(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 470,
            width: 700,
            child: markdown(page.text, 1.25, context)),
        const Gap(14),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textEncode(context,
                  words: page.text.split(' ').length - 1,
                  char: page.text.length,
                  lines: page.text.split('\n').length - 1),
            ],
          ),
        ),
      ],
    );
  }
}

String title() {
  String getTitle = 'Untitled${DateTime.now().microsecond}';
  if (_MarkdownState.pageTitle.text.isNotEmpty) {
    getTitle = _MarkdownState.pageTitle.text;
  }
  return getTitle;
}

// Editor Dialogue
// ignore: must_be_immutable
class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

// ignore: constant_identifier_names
enum Tags { General, Studies, Work, Personal }

class _EditorState extends State<Editor> {
  static Tags selected = Tags.General;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, value, child) {
      return SizedBox(
        width: 700,
        child: Column(
          children: [
            const Gap(20),
            SegmentedButton(
              segments: const [
                ButtonSegment(
                    value: Tags.General,
                    label: Text('General', style: TextStyle(fontSize: 17))),
                ButtonSegment(
                    value: Tags.Studies,
                    label: Text('Studies', style: TextStyle(fontSize: 17))),
                ButtonSegment(
                    value: Tags.Work,
                    label: Text('Work', style: TextStyle(fontSize: 17))),
                ButtonSegment(
                    value: Tags.Personal,
                    label: Text('Personal', style: TextStyle(fontSize: 17))),
              ],
              selected: <Tags>{selected},
              onSelectionChanged: (Set<Tags> newSelection) => {
                setState(() {
                  selected = newSelection.first;
                })
              },
              style: ButtonStyle(
                  side: MaterialStatePropertyAll(BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1))),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  shadowColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.background)),
            ),
            toolbar(_MarkdownState.page, context),
            Container(
              height: 410,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1)),
                // TextBox
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: textField(
                          context,
                          lines: 11,
                          onSubmitted: (text) {
                            setState(() {
                              _MarkdownState.page.text += '\n';
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                            });
                          },
                          controller: _MarkdownState.page,
                          focusNode: _MarkdownState._focusNode,
                          color: Colors.transparent,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      );
    });
  }
}