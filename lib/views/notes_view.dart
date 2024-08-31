// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ozan/providers/filter_db.dart';
import 'package:ozan/providers/preferences.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/files/pdf_export.dart';
import 'package:ozan/views/create_view.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:popover/popover.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/views/update_view.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) =>
          Consumer<DatabaseProvider>(builder: (context, value, child) {
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
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: value.notesList,
                        builder: (context,
                            AsyncSnapshot<List<NotesModel>> snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            List<NotesModel> notes = snapshot.data!;

                            // Sort the notes by date in descending order
                            notes.sort((a, b) {
                              DateTime dateA =
                                  DateFormat('d MMM, yy').parse(a.date);
                              DateTime dateB =
                                  DateFormat('d MMM, yy').parse(b.date);
                              return dateB.compareTo(dateA);
                            });

                            final filterState =
                                Provider.of<FilterState>(context);

                            notes = filterState.showFavouritesOnly
                                ? snapshot.data!
                                    .where((note) => note.favourite == 1)
                                    .toList()
                                : snapshot.data!;

                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Row(
                                          children: [
                                            FilledButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                side: MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1))),
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(14)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                shadowColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                              ),
                                              child: Text(
                                                  '${notes.length} entries',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary)),
                                            ),
                                            const Gap(14),
                                            FilledButton(
                                              onPressed: () async {
                                                String text = await Markdown
                                                    .files
                                                    .loadFile(context);
                                  
                                                String date =
                                                    DateFormat('d MMM, yy')
                                                        .format(DateTime.now());
                                  
                                                String name = Random()
                                                    .nextInt(10000000)
                                                    .toString();
                                  
                                                if (text.isNotEmpty) {
                                                  value.dbHelper.insert(
                                                      NotesModel(
                                                          title: name,
                                                          description: text,
                                                          date: date,
                                                          favourite: 0,
                                                          tag: 'General'));
                                  
                                                  value.initDatabase();
                                  
                                                  value.setLength();
                                                }
                                              },
                                              style: ButtonStyle(
                                                side: MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1))),
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(14)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                shadowColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.folder,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      size: 18),
                                                  const Gap(8),
                                                  Text('Open',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary)),
                                                ],
                                              ),
                                            ),
                                            const Gap(10),
                                            FilledButton(
                                              onPressed: () {
                                                Provider.of<Navigation>(context,
                                                        listen: false)
                                                    .getPage(const Markdown());
                                              },
                                              style: ButtonStyle(
                                                side: MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1))),
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(14)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                shadowColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.pencil,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      size: 19),
                                                  const Gap(4),
                                                  Text('Write',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: IconButton(
                                            onPressed: () {
                                              SnackBarUtils.showSnackbar(
                                                  context,
                                                  LucideIcons.badgeAlert,
                                                  "This feature is under development.");
                                            },
                                            icon: Icon(LucideIcons.search,
                                                size: 21,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                    .withOpacity(0.9)),
                                            style: const ButtonStyle(
                                                overlayColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.transparent))),
                                      )
                                    ],
                                  ),
                                  const Gap(14),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 500,
                                                mainAxisExtent: 180),
                                        scrollDirection: Axis.vertical,
                                        itemCount: notes.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            overlayColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.transparent),
                                            highlightColor: Colors.transparent,
                                            splashFactory: null,
                                            onTap: () {
                                              Provider.of<Navigation>(context,
                                                      listen: false)
                                                  .getPage(Update(
                                                      note: notes[index]));
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(4),
                                              padding: const EdgeInsets.all(6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FilledButton(
                                                        onPressed: () {},
                                                        style: ButtonStyle(
                                                          shape: MaterialStatePropertyAll(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                          side: MaterialStatePropertyAll(
                                                              BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary
                                                                      .withOpacity(
                                                                          0.1))),
                                                          padding:
                                                              const MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .all(8)),
                                                          overlayColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .transparent),
                                                          shadowColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .transparent),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background),
                                                        ),
                                                        child: Text(
                                                            notes[index].date,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary)),
                                                      ),
                                                      Row(
                                                        children: [
                                                          FilledButton(
                                                              onPressed:
                                                                  () async {
                                                                if (notes[index]
                                                                        .favourite ==
                                                                    0) {
                                                                  value.dbHelper
                                                                      .update(
                                                                          NotesModel(
                                                                    title: notes[
                                                                            index]
                                                                        .title,
                                                                    description:
                                                                        notes[index]
                                                                            .description,
                                                                    date: notes[
                                                                            index]
                                                                        .date,
                                                                    id: notes[
                                                                            index]
                                                                        .id,
                                                                    favourite:
                                                                        1,
                                                                    tag: notes[
                                                                            index]
                                                                        .tag,
                                                                  ));
                                                                } else if (notes[
                                                                            index]
                                                                        .favourite ==
                                                                    1) {
                                                                  value.dbHelper
                                                                      .update(
                                                                          NotesModel(
                                                                    title: notes[
                                                                            index]
                                                                        .title,
                                                                    description:
                                                                        notes[index]
                                                                            .description,
                                                                    date: notes[
                                                                            index]
                                                                        .date,
                                                                    id: notes[
                                                                            index]
                                                                        .id,
                                                                    favourite:
                                                                        0,
                                                                    tag: notes[
                                                                            index]
                                                                        .tag,
                                                                  ));
                                                                }
                                                                value
                                                                    .initDatabase();
                                                                value
                                                                    .setLength();
                                                              },
                                                              style:
                                                                  const ButtonStyle(
                                                                padding: MaterialStatePropertyAll(
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                                overlayColor:
                                                                    MaterialStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                                shadowColor:
                                                                    MaterialStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                              ),
                                                              child: Tooltip(
                                                                message: 'Pin',
                                                                child: Icon(
                                                                    notes[index].favourite ==
                                                                            0
                                                                        ? LucideIcons
                                                                            .pin
                                                                        : LucideIcons
                                                                            .pinOff,
                                                                    color: notes[index]
                                                                                .favourite ==
                                                                            0
                                                                        ? Theme.of(context)
                                                                            .colorScheme
                                                                            .tertiary
                                                                            .withOpacity(
                                                                                0.9)
                                                                        : Theme.of(context)
                                                                            .colorScheme
                                                                            .tertiary
                                                                            .withOpacity(0.9),
                                                                    size: 21),
                                                              )),
                                                          SizedBox(
                                                              child: Delete(
                                                                  id: notes[
                                                                          index]
                                                                      .id)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Gap(7),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6),
                                                    child: Text(
                                                        notes[index].title,
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary
                                                                .withOpacity(
                                                                    0.9))),
                                                  ),
                                                  const Gap(10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FilledButton(
                                                        onPressed: () {},
                                                        style: ButtonStyle(
                                                          shape: MaterialStatePropertyAll(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                          side: MaterialStatePropertyAll(
                                                              BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary
                                                                      .withOpacity(
                                                                          0.1))),
                                                          padding:
                                                              const MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .all(8)),
                                                          overlayColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .transparent),
                                                          shadowColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .transparent),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background),
                                                        ),
                                                        child: Text(
                                                          notes[index].tag,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 6),
                                                          child: IconButton(
                                                              icon: Icon(
                                                                  LucideIcons
                                                                      .download,
                                                                  size: 20,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .tertiary
                                                                      .withOpacity(
                                                                          0.95)),
                                                              onPressed:
                                                                  () async {
                                                                await PdfExport
                                                                    .generateAndSavePDF(
                                                                        context,
                                                                        notes[
                                                                            index]);
                                                              },
                                                              style: ButtonStyle(
                                                                  overlayColor: MaterialStatePropertyAll(Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary)),
                                                              tooltip:
                                                                  'Export to PDF')),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Visibility(
                              visible: snapshot.connectionState ==
                                  ConnectionState.done,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Row(
                                          children: [
                                            FilledButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                side: MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1))),
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(14)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                shadowColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                              ),
                                              child: Text('0 entries',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary)),
                                            ),
                                            const Gap(14),
                                            FilledButton(
                                              onPressed: () async {
                                                String text = await Markdown
                                                    .files
                                                    .loadFile(context);

                                                String date =
                                                    DateFormat('d MMM, yy')
                                                        .format(DateTime.now());

                                                String name = Random()
                                                    .nextInt(10000000)
                                                    .toString();

                                                if (text.isNotEmpty) {
                                                  value.dbHelper.insert(
                                                      NotesModel(
                                                          title: name,
                                                          description: text,
                                                          date: date,
                                                          favourite: 0,
                                                          tag: 'General'));

                                                  value.initDatabase();

                                                  value.setLength();
                                                }
                                              },
                                              style: ButtonStyle(
                                                side: MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1))),
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(14)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                shadowColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.folder,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      size: 18),
                                                  const Gap(8),
                                                  Text('Open',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary)),
                                                ],
                                              ),
                                            ),
                                            const Gap(10),
                                            FilledButton(
                                              onPressed: () {
                                                Provider.of<Navigation>(context,
                                                        listen: false)
                                                    .getPage(const Markdown());
                                              },
                                              style: ButtonStyle(
                                                side: MaterialStatePropertyAll(
                                                    BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1))),
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(14)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                shadowColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.pencil,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      size: 19),
                                                  const Gap(4),
                                                  Text('Write',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: IconButton(
                                            onPressed: () {
                                              SnackBarUtils.showSnackbar(
                                                  context,
                                                  LucideIcons.badgeAlert,
                                                  "This feature is under development.");
                                            },
                                            icon: Icon(LucideIcons.search,
                                                size: 21,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                    .withOpacity(0.9)),
                                            style: const ButtonStyle(
                                                overlayColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.transparent))),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Begin writing!',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                    .withOpacity(0.8))),
                                        const Gap(20),

                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              getButton(context, 'Markdown Support', LucideIcons.textCursor),
                                          
                                              const Gap(10),
                                          
                                              getButton(context, 'LaTex & Syntax Highlighting', LucideIcons.code2),
                                          
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ])),
          ),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class Delete extends StatelessWidget {
  Delete({super.key, required this.id});

  int? id;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) => Builder(builder: (context) {
        return IconButton(
            style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.background)),
            onPressed: () {
              showPopover(
                context: context,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                direction: PopoverDirection.left,
                shadow: List.empty(),
                arrowWidth: 0,
                arrowHeight: 0,
                bodyBuilder: (context) {
                  return SizedBox(
                      child: IconButton(
                          onPressed: () {
                            value.dbHelper.delete(id);

                            value.initDatabase();

                            value.setLength();

                            Navigator.pop(context);
                          },
                          icon: Icon(LucideIcons.trash,
                              size: 20,
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.9)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.background),
                              side: MaterialStatePropertyAll(BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1))),
                              overlayColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(10)),
                              shadowColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              surfaceTintColor: const MaterialStatePropertyAll(
                                  Colors.transparent))));
                },
              );
            },
            icon: const Icon(CupertinoIcons.ellipsis, size: 22),
            padding: EdgeInsets.zero,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9));
      }),
    );
  }
}

List<Color> getColor(String tag, context) {
  if (tag == 'General') {
    return [
      const Color.fromRGBO(247, 247, 246, 1),
      const Color.fromARGB(255, 239, 239, 238),
      const Color.fromRGBO(31, 28, 25, 1)
    ];
  } else if (tag == 'Work') {
    return [
      const Color.fromRGBO(255, 234, 236, 1),
      const Color.fromARGB(255, 255, 223, 226),
      const Color.fromRGBO(140, 40, 67, 1),
    ];
  } else if (tag == 'Studies') {
    return [
      const Color.fromRGBO(221, 251, 235, 1),
      const Color.fromARGB(255, 207, 245, 209),
      Colors.green.shade900.withOpacity(0.9)
    ];
  } else if (tag == 'Personal') {
    return [
      Colors.blue.shade50.withOpacity(0.4),
      Colors.blue.shade200.withOpacity(0.4),
      Colors.blue.shade900
    ];
  }

  return [
    Colors.blue.shade50.withOpacity(0.6),
    Colors.blue.shade200.withOpacity(0.6),
    Colors.blue.shade900
  ];
}

Widget getButton(context, String title, IconData icon) {
  return FilledButton(
    onPressed: () {
    },
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
        Icon(icon,
            color: Theme.of(context).colorScheme.tertiary, size: 19),
        const Gap(8),
        Text(title,
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.tertiary)),
      ],
    ),
  );
}
