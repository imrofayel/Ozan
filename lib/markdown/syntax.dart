import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
// ignore: depend_on_referenced_packages
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

    if(element.attributes['class'] == null){
      return Text(element.textContent, textScaler: const TextScaler.linear(1.3), style: TextStyle(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8), color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Roboto Mono'));
    }

    else{

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

        Padding(

          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),

          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
            children: [
              
            FilledButton(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(15)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary)), child: Text(lang, textScaler: const TextScaler.linear(1.3), style: const TextStyle(fontFamily: 'Inter'))),
              
            IconButton(onPressed: (){
              copyToClipboard(context, element.textContent);
              SnackBarUtils.showSnackbar(context, FluentIcons.copy_24_regular, "Code copied");
            }, icon: const Icon(FluentIcons.copy_24_regular), padding: EdgeInsets.zero),
            ],
          ),
        ),
    
        HighlightView(
 
        // The original code to be highlighted
        element.textContent,
      
        // Specify language
        // It is recommended to give it a value for performance
        language: language,
      
        // Specify highlight theme
        // All available themes are listed in `themes` folder
        theme: Theme.of(context).brightness ==
                Brightness.light
            ? arduinoLightTheme
            : nordTheme,
        
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
    
        textStyle: const TextStyle(fontSize: 17, fontFamily: "Roboto Mono", height: 2),
        ),
      ]
    );
    }
  }
}


const nordTheme = {
  'root':
      TextStyle(backgroundColor: Colors.transparent, color: Color(0xffD8DEE9)),
  'subst': TextStyle(color: Color(0xffD8DEE9)),
  'selector-tag': TextStyle(color: Color(0xff81A1C1)),
  'selector-id':
      TextStyle(color: Color(0xff8FBCBB)),
  'selector-class': TextStyle(color: Color(0xff8FBCBB)),
  'selector-attr': TextStyle(color: Color(0xff8FBCBB)),
  'selector-pseudo': TextStyle(color: Color(0xff88C0D0)),
  'addition': TextStyle(backgroundColor: Color.fromRGBO(163, 190, 140, 0.5)),
  'deletion': TextStyle(backgroundColor: Color.fromRGBO(191, 97, 106, 0.5)),
  'built_in': TextStyle(color: Color(0xff8FBCBB)),
  'type': TextStyle(color: Color(0xff8FBCBB)),
  'class': TextStyle(color: Color(0xff8FBCBB)),
  'function': TextStyle(color: Color(0xff88C0D0)),
  'keyword': TextStyle(color: Color(0xff81A1C1)),
  'literal': TextStyle(color: Color(0xff81A1C1)),
  'symbol': TextStyle(color: Color(0xff81A1C1)),
  'number': TextStyle(color: Color(0xffB48EAD)),
  'regexp': TextStyle(color: Color(0xffEBCB8B)),
  'string': TextStyle(color: Color(0xffA3BE8C)),
  'title': TextStyle(color: Color(0xff8FBCBB)),
  'params': TextStyle(color: Color(0xffD8DEE9)),
  'bullet': TextStyle(color: Color(0xff81A1C1)),
  'code': TextStyle(color: Color(0xff8FBCBB)),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'formula': TextStyle(color: Color(0xff8FBCBB)),
  'strong': TextStyle(fontWeight: FontWeight.w500),
  'quote': TextStyle(color: Color(0xff4C566A)),
  'comment': TextStyle(color: Color(0xff4C566A)),
  'doctag': TextStyle(color: Color(0xff8FBCBB)),
  'meta': TextStyle(color: Color(0xff5E81AC)),
  'meta-keyword': TextStyle(color: Color(0xff5E81AC)),
  'meta-string': TextStyle(color: Color(0xffA3BE8C)),
  'attr': TextStyle(color: Color(0xff8FBCBB)),
  'attribute': TextStyle(color: Color(0xffD8DEE9)),
  'builtin-name': TextStyle(color: Color(0xff81A1C1)),
  'name': TextStyle(color: Color(0xff81A1C1)),
  'section': TextStyle(color: Color(0xff88C0D0)),
  'tag': TextStyle(color: Color(0xff81A1C1)),
  'variable': TextStyle(color: Color(0xffD8DEE9)),
  'template-variable': TextStyle(color: Color(0xffD8DEE9)),
  'template-tag': TextStyle(color: Color(0xff5E81AC)),
};

const arduinoLightTheme = {
  'root':
      TextStyle(backgroundColor: Colors.transparent, color: Color(0xff434f54)),
  'subst': TextStyle(color: Color(0xff434f54)),
  'keyword': TextStyle(color: Color(0xff00979D)),
  'attribute': TextStyle(color: Color(0xff00979D)),
  'selector-tag': TextStyle(color: Color(0xff00979D)),
  'doctag': TextStyle(color: Color(0xff00979D)),
  'name': TextStyle(color: Color(0xff00979D)),
  'built_in': TextStyle(color: Color(0xffD35400)),
  'literal': TextStyle(color: Color(0xffD35400)),
  'bullet': TextStyle(color: Color(0xffD35400)),
  'code': TextStyle(color: Color(0xffD35400)),
  'addition': TextStyle(color: Color(0xffD35400)),
  'regexp': TextStyle(color: Color(0xff00979D)),
  'symbol': TextStyle(color: Color(0xff00979D)),
  'variable': TextStyle(color: Color(0xff00979D)),
  'template-variable': TextStyle(color: Color(0xff00979D)),
  'link': TextStyle(color: Color(0xff00979D)),
  'selector-attr': TextStyle(color: Color(0xff00979D)),
  'selector-pseudo': TextStyle(color: Color(0xff00979D)),
  'type': TextStyle(color: Color(0xff005C5F)),
  'string': TextStyle(color: Color(0xff005C5F)),
  'selector-id': TextStyle(color: Color(0xff005C5F)),
  'selector-class': TextStyle(color: Color(0xff005C5F)),
  'quote': TextStyle(color: Color(0xff005C5F)),
  'template-tag': TextStyle(color: Color(0xff005C5F)),
  'deletion': TextStyle(color: Color(0xff005C5F)),
  'title': TextStyle(color: Color(0xff880000)),
  'section': TextStyle(color: Color(0xff880000)),
  'comment': TextStyle(color: Color.fromRGBO(149, 165, 166, .8)),
  'meta-keyword': TextStyle(color: Color(0xff728E00)),
  'meta': TextStyle(color: Color(0xff434f54)),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'strong': TextStyle(fontWeight: FontWeight.w500),
  'function': TextStyle(color: Color(0xff728E00)),
  'number': TextStyle(color: Color(0xff8A7B52)),
};
