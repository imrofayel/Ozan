// import 'package:dictionaryx/dictionary_msa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/theme/theme.dart';

IconButton button(void Function()? function, IconData icon, context, {Color? color, Color? textColor, Color? overlayColor, required String tooltip}){

  return IconButton(

      tooltip: tooltip,

      onPressed: function, 

      icon: Icon(icon),
    
      style: ButtonStyle(

        backgroundColor: MaterialStatePropertyAll(color ?? Themes.accent),

        fixedSize: const MaterialStatePropertyAll(Size(50, 50)),

        iconSize: const MaterialStatePropertyAll(25),

        iconColor: MaterialStatePropertyAll(textColor ?? Themes.text),

        overlayColor: MaterialStatePropertyAll(overlayColor ?? Colors.white),
      )
  );
}

TextField textField(context, {int? lines = 1, required void Function(String)? onSubmitted, required void Function(String)? onChanged, required TextEditingController controller, FocusNode? focusNode, required Color color, Color? textColor}){

  return TextField(
    
    controller: controller,

    onSubmitted: onSubmitted,

    onChanged: onChanged,

    maxLines: lines,

    focusNode: focusNode,

    style: TextStyle(color: textColor ?? Themes.text, fontSize: 18, height: 2),

    decoration: InputDecoration(

      filled: true,

      fillColor: color,

      hoverColor: Colors.transparent,
      
      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20),

        borderSide: const BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20),
        
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    ),
  );
}

FilledButton tonalButton({required void Function()? fn, required String text, required IconData icon, Size? size, double? textSize, double? iconSize}){

  return FilledButton.tonal(onPressed: fn,

    style: ButtonStyle(

      fixedSize: MaterialStatePropertyAll(size ?? const Size(175, 50)),

      backgroundColor: MaterialStatePropertyAll(Themes.accent),

      shadowColor: const MaterialStatePropertyAll(Colors.transparent),

      overlayColor: const MaterialStatePropertyAll(Colors.white)

    ),
    
    child: Row(

      children: [
        
        Icon(icon, size: iconSize?? 25, color: Themes.text),
    
        const Gap(8),
        
        Text(text, style: TextStyle(fontSize: textSize ?? 18, fontWeight: FontWeight.w400, color: Themes.text)),
      ],
    ),
  );
}


// void dictionaryView(context){

//   showDialog(

//     context: context,

//     builder: (context) {

//       return AlertDialog(

//         shadowColor: Colors.transparent,

//         backgroundColor: Themes.accent,

//         contentPadding: const EdgeInsets.all(8),

//         insetPadding: EdgeInsets.zero,
        
//         content: SizedBox(

//           height: 120,

//           child: Column(
          
//             children: [
          
//               TextField(
              
//                 onSubmitted: (value){
//                   dictionary(context, value);
//                 },     
                
//                 decoration: InputDecoration(
                  
//                   prefixIcon: Icon(Iconsax.search_normal_1, color: Themes.text, size: 26),
                     
//                   border: InputBorder.none,
              
//                   fillColor: Themes.accent,
              
//                   focusColor: Themes.accent,
              
//                   hoverColor: Themes.accent,
//                 ),
              
//                 style: const TextStyle(fontSize: 19),
//               ),

//               const Gap(10),

//               FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(340, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Dictionary may take some time to load once!"))
//             ],
//           ),
//         ),
//       );
//     }
//   );
// }

void searchView(context, TextEditingController search, TextEditingController text){

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        shadowColor: Colors.transparent,

        backgroundColor: Themes.accent,

        contentPadding: const EdgeInsets.all(8),

        insetPadding: EdgeInsets.zero,
        
        content: TextField(
        
          onSubmitted: (value){
            
            if(text.text.toLowerCase().contains(value.toLowerCase())){
          
                SnackBarUtils.showSnackbar(context, Iconsax.tick_circle, "Found");
            }
            else{
                SnackBarUtils.showSnackbar(context, Iconsax.warning_2, "Not Found");
            }
          },     
          
          decoration: InputDecoration(
            
            prefixIcon: Icon(Iconsax.search_normal_1, color: Themes.text, size: 26),
       
            border: InputBorder.none,
        
            fillColor: Themes.accent,
        
            focusColor: Themes.accent,
        
            hoverColor: Themes.accent,
          ),

          style: const TextStyle(fontSize: 19),
        ),
      );
    }
  );
}

void copyToClipboard(context, String text){

      Clipboard.setData(ClipboardData(text: text));

      SnackBarUtils.showSnackbar(context, Iconsax.copy_success, "Copied to clipboard");
  }

// void dictionary(BuildContext context, String word) {

//   String get;

//   try {

//     var dMSA = DictionaryMSA();

//     var entry = dMSA.getEntry(word);

//     get = "(${entry.meanings.first.pos.toString().split('.')[1].toLowerCase()}) ${entry.meanings.first.description}.\nSynonyms: ${entry.synonyms.toSet()}\ne.g., ${entry.meanings.first.examples.first}";

//     SnackBarUtils.showDictionarySnackbar(context, Iconsax.eye, get);

//   } catch (e) {

//     get = "Check your spelling or try another word";
//     SnackBarUtils.showDictionarySnackbar(context, Iconsax.eye_slash, get);
//   }
// }


SingleChildScrollView textEncode({required int words, required int char, required int lines}){

  return SingleChildScrollView(

    scrollDirection: Axis.horizontal,

    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
      children: [
    
        FilledButton.tonal(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: MaterialStatePropertyAll(Themes.accent), shadowColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$words words", style: const TextStyle(fontSize: 15))),
    
        const Gap(7),
    
        FilledButton.tonal(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: MaterialStatePropertyAll(Themes.accent), shadowColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$char characters", style: const TextStyle(fontSize: 15))),
    
        const Gap(7),
    
        FilledButton.tonal(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: MaterialStatePropertyAll(Themes.accent), shadowColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$lines lines", style: const TextStyle(fontSize: 15))),
      ],
    ),
  );
}

IconButton suffix(context){
  return IconButton(onPressed: (){
        SnackBarUtils.showSnackbar(context, Icons.window_sharp, "Press Windows + H");
      }, icon: const Icon(Iconsax.microphone), padding: const EdgeInsets.all(1));
}

TextField titleBox({required TextEditingController controller}){

  return TextField(

    controller: controller,

    decoration: InputDecoration(

      hintText: "Untitled",

      hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Themes.text.withOpacity(0.8)),

      constraints: const BoxConstraints(maxHeight: 70, maxWidth: 520),

      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(50),

        borderSide: const BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(50),
        
        borderSide: const BorderSide(color: Colors.transparent),
      ),

      contentPadding: const EdgeInsets.all(20),

      border: InputBorder.none,

      filled: true,

      fillColor: Themes.accent,

      focusColor: Themes.accent,

      hoverColor: Themes.accent
    ),

    style: const TextStyle(fontSize: 20),
  );
}