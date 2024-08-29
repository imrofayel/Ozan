import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ozan/components/snackbar.dart';

Widget toolbar(TextEditingController controller, context){

  return Container(
                    
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(16),
    ),

    height: 60,
                    
    child: Padding(

      padding: const EdgeInsets.all(0.0),

      child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
      
          children: [
            
            IconButton(onPressed: () => applyFormatting(controller, '**'), icon: Icon(LucideIcons.bold, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Bold", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),
            
            IconButton(onPressed: () => applyFormatting(controller, '*'), icon: Icon(LucideIcons.italic, size: 20, color: Theme.of(context).colorScheme.tertiary,), tooltip: "Italic", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),
      
            const Gap(6),

            IconButton(onPressed: () => applyCodeFormatting(controller, context), icon: Icon(LucideIcons.code2, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Code Block", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary))),
      
            const Gap(6),

            IconButton(onPressed: () => applyQuoteFormatting(controller), icon: Icon(LucideIcons.quote, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Quote", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),
      
            const Gap(6),

            IconButton(onPressed: ()=> tableDialog(context, controller), icon: Icon(LucideIcons.table2, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Table", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),
      
            const Gap(6),

            IconButton(onPressed: () => applyListFormatting(controller, '-'), icon: Icon(LucideIcons.list, size: 22, color: Theme.of(context).colorScheme.tertiary), tooltip: "Bullet List", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),
      
            const Gap(6),

            IconButton(onPressed: () => applyListFormatting(controller, '1. '), icon: Icon(LucideIcons.listOrdered, size: 22, color: Theme.of(context).colorScheme.tertiary), tooltip: "Numbered List", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),

            const Gap(6),

            IconButton(onPressed: () => linkDialog(context, controller), icon: Icon(LucideIcons.link2, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Link", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),),

            const Gap(6),

            IconButton(onPressed: () => applyFormatting(controller, '=='), icon: Icon(LucideIcons.highlighter, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Link", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary))),

            const Gap(6),

            IconButton(onPressed: () => applyFormatting(controller, '~~'), icon: Icon(LucideIcons.strikethrough, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Strikethrough", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary))),

            const Gap(6),

            IconButton(onPressed: () => applyFormatting(controller, '%%'), icon: Icon(LucideIcons.waves, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Wavy Underline", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary))),

            const Gap(6),

            IconButton(onPressed: () => applyColor(controller), icon: Icon(LucideIcons.contrast, size: 20, color: Theme.of(context).colorScheme.tertiary), tooltip: "Colored Highlighter", style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary))),
          
          ],
      ),
    ),
  );
}

void applyCodeFormatting(TextEditingController controller, context) {

    TextSelection selection = controller.selection;

    String text = controller.text;

    try {

    String newText =
        '${text.substring(0, selection.start)}\n```Text\n${text.substring(selection.start, selection.end).isNotEmpty ? text.substring(selection.start, selection.end) : 'Write your code here...'}\n```\n${text.substring(selection.end)}';

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.end + 4),

    );
    } catch (e) {
      // Text field not selected.
    }
}

void applyListFormatting(TextEditingController controller, String token) {

    TextSelection selection = controller.selection;

    String text = controller.text;

    try {
      String newText =
          '${text.substring(0, selection.start)}\n$token ${text.substring(selection.start, selection.end)}\n${text.substring(selection.end)}';

      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.end + 4),
      );
    } catch (e) {
      // Textfield not selected
    }
}

void applyQuoteFormatting(TextEditingController controller) {

    TextSelection selection = controller.selection;

    String text = controller.text;

    try {
      String newText =
          '${text.substring(0, selection.start)}\n>${text.substring(selection.start, selection.end)}\n${text.substring(selection.end)}';

      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.end + 4),
      );
    } catch (e) {
      // Textfield not selected
    }

}

// Inline formatting i.e., Bold, Italic, Underline
void applyFormatting(TextEditingController controller, String format) {

    // Get the selected text range
    TextSelection selection = controller.selection;

    // Get the current text in the TextField
    String text = controller.text;

    try {
      String newText =
          '${text.substring(0, selection.start)}$format${text.substring(selection.start, selection.end)}$format${text.substring(selection.end)}';

      // Update the text in the TextField
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.end + 4), // Set the cursor after the inserted '**'
      );
    } catch (e) {
      // Textfield not selected
    }    
}

void applyColor(TextEditingController controller) {

    // Get the selected text range
    TextSelection selection = controller.selection;

    // Get the current text in the TextField
    String text = controller.text;

    try {
      String newText =
          '${text.substring(0, selection.start)}=#E1F5FE=${text.substring(selection.start, selection.end)}=#01579B=${text.substring(selection.end)}';

      // Update the text in the TextField
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.end + 10), // Set the cursor after the inserted '**'
      );
    } catch (e) {
      // Textfield not selected
    }    
}

void applyTable(int rows, int cols, TextEditingController controller){

    // Get the selected text range
    TextSelection selection = controller.selection;

    // Get the current text in the TextField
    String text = controller.text;

    try {
      String newText =
          '${text.substring(0, selection.start)}\n${generateMarkdownTable(rows, cols)}\n${text.substring(selection.end)}';

      // Update the text in the TextField
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.end + 4), // Set the cursor after the inserted '**'
      );
    } catch (e) {
      // Textfield not selected
    }  
}

String generateMarkdownTable(int rows, int cols) {
  // Markdown table header
  var table = "|";
  for (int j = 1; j <= cols; ++j) {
    table += " Heading $j |";
  }

  table += "\n";

  // Markdown table separator
  table += "|";
  for (int j = 1; j <= cols; ++j) {
    table += "------|";
  }
  table += "\n";

  for (int i = 1; i <= rows; ++i) {
    table += "|";
    for (int j = 1; j <= cols; ++j) {
      table += " ($i, $j) |";
    }
    table += "\n";
  }

  return table;
}

void tableDialog(context, TextEditingController controller){

  TextEditingController row = TextEditingController();

  TextEditingController col = TextEditingController();

  showDialog(

    context: context,
    
    barrierColor: Colors.transparent,

    builder: (context) {

      return AlertDialog(

        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)), borderRadius: BorderRadius.circular(20)),

        backgroundColor: Theme.of(context).colorScheme.background,

        elevation: 0,

        shadowColor: Colors.transparent,

        contentPadding: const EdgeInsets.all(4),

        insetPadding: EdgeInsets.zero,
        
        content: SizedBox(

          height: 120, width: 180,

          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
          
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
          
                children: [
              
                  TextField( 

                    controller: row,
                    
                    decoration: InputDecoration( 
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 100),
                      
                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(LucideIcons.rows, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), size: 20), tooltip: "Rows", style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20))), padding: const MaterialStatePropertyAll(EdgeInsets.all(12)), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                                   
                      filled: false,
                  
                      fillColor: Theme.of(context).colorScheme.primary,
                  
                      focusColor: Theme.of(context).colorScheme.primary,
                  
                      hoverColor: Theme.of(context).colorScheme.primary,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                      
                    ),
                  
                    style: const TextStyle(fontSize: 17, fontFamily: "Inter"),
                  ),
              
                  const Gap(10),
              
                  TextField( 

                    controller: col,
                    
                    decoration: InputDecoration(
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 100),
                      
                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(LucideIcons.columns, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), size: 20), tooltip: "Columns", style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20))), padding: const MaterialStatePropertyAll(EdgeInsets.all(12)), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                                   
                      filled: false,
                  
                      fillColor: Theme.of(context).colorScheme.primary,
                  
                      focusColor: Theme.of(context).colorScheme.primary,
                  
                      hoverColor: Theme.of(context).colorScheme.primary,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                      
                    ),
                  
                    style: const TextStyle(fontSize: 17, fontFamily: "Inter"),
                  ),
                ],
              ),

              const Gap(14),
                        
              IconButton.filled(onPressed: (){

                if(isValidInteger(row.text) && isValidInteger(col.text)){
                  applyTable(int.parse(row.text), int.parse(col.text), controller);
                  Navigator.pop(context);
                }
                else{
                  SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "Please enter valid integer values for both row and col");
                }
              },

              icon: Icon(LucideIcons.plus, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), size: 22),  tooltip: "Create", style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),

                      overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)))
            ],
          ),
        ),
      );
    }
  );
}

bool isValidInteger(String value) {
  try {
    // Attempt to parse the string to an integer
    int.parse(value);
    return true;
  } catch (e) {
    // If an exception occurs, it means the string is not a valid integer
    return false;
  }
}

void linkDialog(context, TextEditingController controller){

  TextEditingController title = TextEditingController();

  TextEditingController link = TextEditingController();

  showDialog(

    context: context,

    barrierColor: Colors.transparent,

    builder: (context) {

      return AlertDialog(

        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)), borderRadius: BorderRadius.circular(20)),

        backgroundColor: Theme.of(context).colorScheme.primary,

        elevation: 0,

        shadowColor: Colors.transparent,

        contentPadding: const EdgeInsets.all(4),

        insetPadding: EdgeInsets.zero,

        surfaceTintColor: Colors.transparent,
        
        content: SizedBox(

          height: 220, width: 200,

          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
          
              Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
          
                children: [
              
                  TextField( 

                    controller: title,
                    
                    decoration: InputDecoration(

                      hintText: "title",

                      hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter', fontSize: 18),
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 250),
                         
                      border: InputBorder.none,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                    ),
                  
                    style: const TextStyle(fontSize: 20, fontFamily: 'Inter'),

                    cursorHeight: 30,

                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
              
                  const Gap(14),
              
                  TextField( 

                    controller: link,
                    
                    decoration: InputDecoration(

                      hintText: 'link',

                      hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter', fontSize: 18),
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 250),
                      
                      prefixIcon: Padding(
                      
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 10, 0),
                      
                      child: IconButton(onPressed: (){}, icon: Icon(LucideIcons.link, color: Theme.of(context).colorScheme.tertiary, size: 20), tooltip: "Link", style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),

                      overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background))),
                      ),
                                   
                      filled: true,
                  
                      fillColor: Theme.of(context).colorScheme.primary,
                  
                      focusColor: Theme.of(context).colorScheme.primary,
                  
                      hoverColor: Theme.of(context).colorScheme.primary,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                    ),
                  
                    style: const TextStyle(fontSize: 19, fontFamily: 'Inter'),
                  ),
                ],
              ),
              
              const Gap(20),
          
              IconButton.filled(onPressed: (){
              
                if(title.text.isNotEmpty && link.text.isNotEmpty){
              
                      TextSelection selection = controller.selection;
              
                      // Get the current text in the TextField
                      String text = controller.text;
              
                      try {
              
                        String newText =
                            '${text.substring(0, selection.start)}[${title.text}](${link.text})${text.substring(selection.end)}';
              
                        // Update the text in the TextField
                        controller.value = TextEditingValue(
                          text: newText,
                          selection: TextSelection.collapsed(offset: selection.end + 4), // Set the cursor after the inserted '**'
                        );
                      } catch (e) {
                        // Textfield not selected
                      }
                }
                Navigator.pop(context);
              },
              
              icon: Icon(LucideIcons.plus, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), size: 22),  tooltip: "Create", style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),

                      overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)))
            ],
          ),
        ),
      );
    }
  );
}