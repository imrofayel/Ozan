import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:ozan/views/update_view.dart';
import 'package:provider/provider.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';

class GraphViewPage extends StatefulWidget {
  const GraphViewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GraphViewPageState createState() => _GraphViewPageState();
}

class _GraphViewPageState extends State<GraphViewPage> {
  late FruchtermanReingoldAlgorithm builder;

  @override
  void initState() {
    super.initState();
    builder = FruchtermanReingoldAlgorithm();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
      
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)), borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.primary),
        
        child: Scaffold(

          backgroundColor: Colors.transparent,

          appBar: AppBar(
            title: const Text('Graph'),
          ),
          body: Consumer<DatabaseProvider>(
            builder: (context, value, child) {
              return FutureBuilder<List<NotesModel>>(
                future: value.notesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data!;
                    final Graph graph = _buildGraph(notes);
        
                    return Center(
                      child: InteractiveViewer(
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(0.0),
                        minScale: 1,
                        maxScale: 1.6,
                        child: GraphView(
                          animated: true,
                          graph: graph,
                          algorithm: builder,
                          paint: Paint()
                            ..color = Theme.of(context).colorScheme.secondary.withOpacity(0.1)
                            ..strokeWidth = 0.6
                            ..style = PaintingStyle.stroke,
                          builder: (Node node) {
                            var nodeId = node.key!.value;
        
                            if (nodeId == 'NOTES') {
                              return _buildNode(
                                  nodeId, getColor(nodeId, context)[0], getColor(nodeId, context)[2], getColor(nodeId, context)[1], false
                                  );
                            } else if (notes.any((note) => note.tag == nodeId)) {
                              return _buildNode(nodeId, getColor(nodeId, context)[0], getColor(nodeId, context)[2], getColor(nodeId, context)[1], false);
                            } else {
                              return _buildNode(nodeId, getColor(nodeId, context)[0], getColor(nodeId, context)[2], getColor(nodeId, context)[1], true);
                            }
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Graph _buildGraph(List<NotesModel> notes) {
    final graph = Graph();

    // Mapping tags to their respective notes
    final Map<String, List<NotesModel>> tagMap = {};
    for (var note in notes) {
      tagMap.putIfAbsent(note.tag, () => []).add(note);
    }

    // Adding tags as nodes
    for (var tag in tagMap.keys) {
      final tagNode = Node.Id(tag);
      graph.addNode(tagNode);

      // Adding notes under each tag as nodes
      for (var note in tagMap[tag]!) {
        // Create a unique identifier based on tag and title
        final noteNode = Node.Id(note.title);
        graph.addNode(noteNode);
        graph.addEdge(tagNode, noteNode);
      }
    }

    for (var edge in graph.edges) {
      edge.paint = Paint()
        ..color = Theme.of(context).colorScheme.secondary.withOpacity(0.3)
 // Change this to your desired color
        ..strokeWidth = 1.4 // Change this to your desired width
        ..style = PaintingStyle.stroke;
    }

    return graph;
  }

  Widget _buildNode(String text, Color color, Color textC, Color border, bool isNote) {
    return InkWell(
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: isNote ? () => _openNoteUpdate(text) : null,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).colorScheme.primary : color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? textC
                  : Theme.of(context).colorScheme.tertiary,
              fontSize: 16),
        ),
      ),
    );
  }

  void _openNoteUpdate(String nodeText) {
    // Find the note corresponding to the clicked node
    final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);
    databaseProvider.notesList.then((notes) {
      final clickedNote = notes.firstWhere(
            (note) => note.title == nodeText,
        orElse: () => NotesModel(title: '', description: '', date: '', favourite: 0, tag: ''),
      );

      // If a matching note is found, open the Update view
      if (clickedNote.title.isNotEmpty) {
        Provider.of<Navigation>(context, listen: false).getPage(Update(note: clickedNote));
      }
    });
  }

  List<Color> getColor(String tag, BuildContext context) {
    if (tag == 'General') {
      return [
        Theme.of(context).colorScheme.background,
        Colors.transparent,
        Theme.of(context).colorScheme.tertiary
      ];
    } else if (tag == 'Work') {
      return [
        Theme.of(context).colorScheme.background,
        Colors.transparent,
        Theme.of(context).colorScheme.tertiary
      ];
    } else if (tag == 'Studies') {
      return [
        Theme.of(context).colorScheme.background,
        Colors.transparent,
        Theme.of(context).colorScheme.tertiary
      ];
    } else if (tag == 'Personal') {
      return [
        Theme.of(context).colorScheme.background,
        Colors.transparent,
        Theme.of(context).colorScheme.tertiary
      ];
    }

    return [
        Colors.white,
        Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        Theme.of(context).colorScheme.tertiary.withOpacity(0.9)
    ];
  }
}
