import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class EditorComponent extends StatelessWidget {
   
  EditorComponent({super.key, required this.controller, required this.question});

  TextEditingController controller;

  String question;

  @override
  Widget build(BuildContext context) {
    
    return Center(

      child: SizedBox(
      
        height: 500,
      
        width: 600,
      
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
        
            Text(question, textScaler: const TextScaler.linear(1.6)),

            const Gap(14),

            Expanded(

              child: TextField(controller: controller, decoration: const InputDecoration(
              
                border: InputBorder.none,
              
              ),
              
              maxLines: 18,

              cursorColor: Theme.of(context).colorScheme.secondary,

              style: const TextStyle(fontSize: 20),
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}