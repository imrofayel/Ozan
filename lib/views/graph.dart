import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
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
    return Scaffold(
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
                      animated: false,
                      graph: graph,
                      algorithm: builder,
                      paint: Paint()
                        ..color = Colors.blue
                        ..strokeWidth = 1
                        ..style = PaintingStyle.stroke,
                      builder: (Node node) {
                        var nodeId = node.key!.value;
                        if (nodeId == 'NOTES') {
                          return _buildNode(nodeId, Colors.blue);
                        } else if (notes.any((note) => note.tag == nodeId)) {
                          return _buildNode(nodeId, Colors.green);
                        } else {
                          return _buildNode(nodeId, Colors.orange);
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

    return graph;
  }

  Widget _buildNode(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
