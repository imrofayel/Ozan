import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graph'),

        centerTitle: true,

        leading: InkWell(

          onTap: () => {Navigator.pop(context)},

          child: Icon(
                CupertinoIcons.arrow_left,
                size: 20,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
              ),
        ),
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
                        ..color = Colors.grey.shade50
                        ..strokeWidth = 0.6
                        ..style = PaintingStyle.stroke,
                        
                      builder: (Node node) {
                        var nodeId = node.key!.value;
                        if (nodeId == 'NOTES') {
                          return _buildNode(nodeId, Theme.of(context).brightness == Brightness.light
                              ? Colors.blue.shade50.withOpacity(0.3)
                              : Theme.of(context).colorScheme.primary);
                        } else if (notes.any((note) => note.tag == nodeId)) {
                          return _buildNode(nodeId, Theme.of(context).brightness == Brightness.light
                              ? Colors.blue.shade50
                              : Theme.of(context).colorScheme.primary);
                        } else {
                          return _buildNode(nodeId, Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade50
                              : Theme.of(context).colorScheme.primary);
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

    for (var edge in graph.edges) {
      edge.paint = Paint()
      ..color = Colors.grey  // Change this to your desired color
      ..strokeWidth = 1.3    // Change this to your desired width
      ..style = PaintingStyle.stroke;
    }

    return graph;
  }

  // Widget _buildNode(String text, Color color) {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(14),
  //       border: Border.all(color: Theme.of(context).brightness == Brightness.light
  //                             ? Colors.blue.shade200.withOpacity(0.2)
  //                             : Theme.of(context).colorScheme.secondary, width: 2)
  //     ),
  //     child: Text(
  //       text,
  //       style: TextStyle(color: Theme.of(context).brightness == Brightness.light
  //                             ? Colors.blue.shade900
  //                             : Theme.of(context).colorScheme.tertiary, fontSize: 16),
  //     ),
  //   );
  // }

    Widget _buildNode(String text, Color color) {
    return InkWell(
      onTap: () {
        _openNoteUpdate(text);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Theme.of(context).brightness == Brightness.light
                                ? Colors.blue.shade200.withOpacity(0.2)
                                : Theme.of(context).colorScheme.secondary, width: 2)
        ),
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).brightness == Brightness.light
                                ? Colors.blue.shade900
                                : Theme.of(context).colorScheme.tertiary, fontSize: 16),
        ),
      ),
    );
  }

  void _openNoteUpdate(String nodeText) {
    // Find the note corresponding to the clicked node
    final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);
    databaseProvider.notesList.then((notes) {
      final clickedNote = notes.firstWhere(
        (note) => note.title == nodeText || note.tag == nodeText,
        orElse: () => NotesModel(title: '', description: '', date: '', favourite: 0, tag: ''),
      );

      // If a matching note is found, open the Update view
      if (clickedNote.title.isNotEmpty || clickedNote.tag.isNotEmpty) {

          Navigator.push(context, MaterialPageRoute(builder:(context){
                                                  
                                        return Scaffold(
                                                      
                                          body: Row(
                                                      
                                            children: [
                                                      
                                              Expanded(flex: 2, child: SizedBox(
                                                      
                                                child: Padding(
                                                      
                                                  padding: const EdgeInsets.all(20.0),
                                                      
                                                  child: Column(
                                                                
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                
                                                  children: [
                                                    
                                                    IconButton(onPressed: (){
                                                      
                                                      Navigator.pop(context);
                                                                      
                                                    }, 
                                                                    
                                                    icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                                                                    
                                                  ],
                                                ),
                                              ),
                                            )),
                                                      
                                            Expanded(flex: 10, child: Padding(
                                                      
                                              padding: const EdgeInsets.all(26),
                                                      
                                              child: Update(note: clickedNote),
                                            )),
                                                      
                                            const Expanded(flex: 2, child: SizedBox()),
                                                      
                                          ],
                                        ),
                                      );
                                    }));
      }
    });
  }
}
