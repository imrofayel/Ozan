import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
// ignore:, depend_on_referenced_packages 
import 'package:markdown/markdown.dart' as md;
import 'package:ozan/components/components.dart';
import 'package:ozan/components/snackbar.dart';
class CodeElementBuilder extends MarkdownElementBuilder {

    CodeElementBuilder({required this.context});

    // ignore: prefer_typing_uninitialized_variables
    var context;

    @override
    Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {

    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    String lang = 'Plain Text';

    if(language.isNotEmpty){
      lang = language;
    }

    return Column(
    
      mainAxisAlignment: MainAxisAlignment.start,
    
      crossAxisAlignment: CrossAxisAlignment.start,
    
      children: [
        
        const Gap(9),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
          children: [
    
          FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(15)), overlayColor: MaterialStatePropertyAll(Colors.transparent), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: Text(lang)),
    
          IconButton(onPressed: (){
            copyToClipboard(context, element.textContent);
            SnackBarUtils.showSnackbar(context, Iconsax.copy_success, "Code copied");
          }, icon: const Icon(Iconsax.copy), padding: EdgeInsets.zero),
          ],
        ),
    
        HighlightView( 
        // The original code to be highlighted
        element.textContent,
      
        // Specify language
        // It is recommended to give it a value for performance
        language: language,
      
        // Specify highlight theme
        // All available themes are listed in `themes` folder
        theme: MediaQueryData.fromView(View.of(context))
                    .platformBrightness ==
                Brightness.light
            ? atomOneLightTheme
            : atomOneDarkTheme,
        
        padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
    
        textStyle: const TextStyle(fontSize: 16, fontFamily: "Roboto Mono", height: 2),
        ),
      ]
    );
  }
}