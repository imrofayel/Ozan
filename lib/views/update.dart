import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/views/markdown.dart';

// ignore: must_be_immutable
class UpdateView extends StatefulWidget {

  UpdateView({super.key, required this.note});

  NotesModel? note;

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Row(

        children: [

          Expanded(flex: 3, child: SizedBox(

            child: Padding(

              padding: const EdgeInsets.all(20.0),

              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.start,
              
                crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(CupertinoIcons.arrow_left)),
                ],
              ),
            ),
          )),

          Expanded(flex: 8, child: Padding(

            padding: const EdgeInsets.all(26),

            child: Markdown(note: widget.note),
          )),

          const Expanded(flex: 3, child: SizedBox()),

        ],
      ),
    );
  }
}