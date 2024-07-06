import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/components/snackbar.dart';

Widget toolbar(TextEditingController controller, context){

  return Container(
                    
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(16),
    ),

    height: 70,
                    
    child: Padding(

      padding: const EdgeInsets.all(0.0),

      child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
      
          children: [
            
            IconButton(onPressed: () => applyFormatting(controller, '**'), icon: Icon(CupertinoIcons.bold, size: 24, color: Theme.of(context).colorScheme.tertiary), tooltip: "Bold"),
            
            IconButton(onPressed: () => applyFormatting(controller, '*'), icon: Icon(CupertinoIcons.italic, size: 24, color: Theme.of(context).colorScheme.tertiary,), tooltip: "Italic"),
      
            const Gap(6),

            IconButton(onPressed: () => applyCodeFormatting(controller, context), icon: Icon(CupertinoIcons.chevron_left_slash_chevron_right, size: 24, color: Theme.of(context).colorScheme.tertiary), tooltip: "Code Block"),
      
            const Gap(6),

            IconButton(onPressed: () => applyQuoteFormatting(controller), icon: Icon(FluentIcons.text_quote_24_regular, size: 28, color: Theme.of(context).colorScheme.tertiary), tooltip: "Quote"),
      
            const Gap(6),

            IconButton(onPressed: ()=> tableDialog(context, controller), icon: Icon(FluentIcons.table_edit_24_regular, size: 24, color: Theme.of(context).colorScheme.tertiary), tooltip: "Table"),
      
            const Gap(6),

            IconButton(onPressed: () => applyListFormatting(controller, '-'), icon: Icon(FluentIcons.text_bullet_list_24_regular, size: 24, color: Theme.of(context).colorScheme.tertiary), tooltip: "Bullet List"),
      
            const Gap(6),

            IconButton(onPressed: () => applyListFormatting(controller, '1. '), icon: Icon(FluentIcons.text_number_list_ltr_24_regular, size: 24, color: Theme.of(context).colorScheme.tertiary), tooltip: "Numbered List"),

            const Gap(6),

            IconButton(onPressed: () => linkDialog(context, controller), icon: Icon(FluentIcons.link_24_regular, size: 24, color: Theme.of(context).colorScheme.tertiary), tooltip: "Link"),

            const Gap(6),
          
            DropdownMenu(
            
              onSelected: (value){
                
                String temp = '';
                
                switch (value) {
                  case 0:
                    temp = '#';
                    break;
                  
                  case 1:
                    temp = '##';
                    break;
            
                  case 2:
                    temp = '###';
                    break;
            
                  default: temp = '#';
                }
            
                  TextSelection selection = controller.selection;
            
                  String text = controller.text;
            
                  try {
                    String newText =
                        '${text.substring(0, selection.start)}\n$temp ${text.substring(selection.start, selection.end)}\n${text.substring(selection.end)}';
            
                    controller.value = TextEditingValue(
                      text: newText,
                      selection: TextSelection.collapsed(offset: selection.end + 4),
                    );
                  } catch (e) {
                    // Text field not selected
                  }
              },
            
              initialSelection: 2,
            
              width: 90,
            
              textStyle: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),
            
              dropdownMenuEntries: heading,
            )
          ],
      ),
    ),
  );
}


List<DropdownMenuEntry> heading = [

    const DropdownMenuEntry(value: 0, label: "H1", labelWidget: Icon(FluentIcons.text_header_1_24_regular, size: 28)),

    const DropdownMenuEntry(value: 1, label: "H2", labelWidget: Icon(FluentIcons.text_header_2_24_regular, size: 24)),

    const DropdownMenuEntry(value: 2, label: "H3", labelWidget: Icon(FluentIcons.text_header_3_24_regular, size: 24)),

  ];

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

void applyListFormatting(TextEditingController controller, String format) {

    TextSelection selection = controller.selection;

    String text = controller.text;

    try {
      String newText =
          '${text.substring(0, selection.start)}\n$format ${text.substring(selection.start, selection.end)}\n${text.substring(selection.end)}';

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

        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary,), borderRadius: BorderRadius.circular(20)),

        backgroundColor: Theme.of(context).colorScheme.primary,

        elevation: 0,

        shadowColor: Colors.transparent,

        contentPadding: const EdgeInsets.all(4),

        insetPadding: EdgeInsets.zero,
        
        content: SizedBox(

          height: 160, width: 260,

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
                      
                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(FluentIcons.align_left_24_regular, color: Theme.of(context).colorScheme.tertiary, size: 24), tooltip: "Rows", style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(20))), padding: const MaterialStatePropertyAll(EdgeInsets.all(12)), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                                   
                      filled: true,
                  
                      fillColor: Theme.of(context).colorScheme.primary,
                  
                      focusColor: Theme.of(context).colorScheme.primary,
                  
                      hoverColor: Theme.of(context).colorScheme.primary,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                      
                    ),
                  
                    style: const TextStyle(fontSize: 19, fontFamily: "Inter"),
                  ),
              
                  const Gap(10),
              
                  TextField( 

                    controller: col,
                    
                    decoration: InputDecoration(
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 100),
                      
                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(FluentIcons.align_top_24_regular, color: Theme.of(context).colorScheme.tertiary, size: 24), tooltip: "Columns", style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(20))), padding: const MaterialStatePropertyAll(EdgeInsets.all(12)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background))),
                                   
                      filled: true,
                  
                      fillColor: Theme.of(context).colorScheme.primary,
                  
                      focusColor: Theme.of(context).colorScheme.primary,
                  
                      hoverColor: Theme.of(context).colorScheme.primary,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                      
                    ),
                  
                    style: const TextStyle(fontSize: 19, fontFamily: "Inter"),
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

              icon: Icon(FluentIcons.add_24_regular, color: Theme.of(context).colorScheme.tertiary),  tooltip: "Create", style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

                      overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)),)
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

        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary,), borderRadius: BorderRadius.circular(20)),

        backgroundColor: Theme.of(context).colorScheme.primary,

        elevation: 0,

        shadowColor: Colors.transparent,

        contentPadding: const EdgeInsets.all(4),

        insetPadding: EdgeInsets.zero,

        surfaceTintColor: Colors.transparent,
        
        content: SizedBox(

          height: 260, width: 300,

          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
          
              Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
          
                children: [
              
                  TextField( 

                    controller: title,
                    
                    decoration: InputDecoration(

                      hintText: " Title",

                      hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter', fontSize: 20),
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 250),
                         
                      border: InputBorder.none,

                      enabledBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20)),

                      focusedBorder: OutlineInputBorder(borderSide:BorderSide.none, borderRadius: BorderRadius.circular(20))
                    ),
                  
                    style: const TextStyle(fontSize: 20, fontFamily: 'Inter'),

                    cursorHeight: 40,

                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
              
                  const Gap(14),
              
                  TextField( 

                    controller: link,
                    
                    decoration: InputDecoration(
          
                      constraints: const BoxConstraints(maxHeight: 80, maxWidth: 250),
                      
                      prefixIcon: Padding(
                      
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 10, 0),
                      
                      child: IconButton(onPressed: (){}, icon: Icon(FluentIcons.link_24_regular, color: Theme.of(context).colorScheme.tertiary, size: 24), tooltip: "Link", style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

                      overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), padding: const EdgeInsets.all(12),),
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
              
              style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

              overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), padding: const MaterialStatePropertyAll(EdgeInsets.all(12))),
              
              icon: Icon(FluentIcons.add_24_regular, color: Theme.of(context).colorScheme.tertiary,), tooltip: "Create",),
            ],
          ),
        ),
      );
    }
  );
}