import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:gap/gap.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/markdown/highlighting/highlight.dart';
import 'package:ozan/providers/filter_db.dart';
import 'package:ozan/providers/preferences.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:ozan/views/graph.dart';
import 'package:ozan/views/notes_view.dart';
import 'package:ozan/views/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';


// Ensure to replace with your actual API key
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Sidebar(),
            Expanded(child: Placeholder()), // Replace with your main content
          ],
        ),
      ),
    );
  }
}

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(builder: (context, value, child) =>
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _buildIconButton(LucideIcons.inbox, 21, () {

                      Provider.of<Navigation>(context, listen: false).getPage(const NotesView());

                      Provider.of<FilterState>(context, listen: false).isBookmark() ? Provider.of<FilterState>(context, listen: false).toggleShowFavouritesOnly() : (){};
                      
                    }, 'Notes'),
      
                    const Gap(35),
      
                    _buildIconButton(LucideIcons.gitCompare, 21, () {
                      // _navigateTo(context, const GraphViewPage());
                      Provider.of<Navigation>(context, listen: false).getPage(const GraphViewPage());
      
                    }, 'Brain'),
      
                    const Gap(35),
      
                    _buildIconButton(LucideIcons.lasso, 21, () {
                      SnackBarUtils.showSnackbar(context, LucideIcons.badgeAlert, "This feature is under development.");
                    }, 'Draw'),
      
                    const Gap(35),
                    _buildIconButton(!Provider.of<FilterState>(context).isBookmark() ? LucideIcons.pin : LucideIcons.pinOff, 21, (){

                      Provider.of<Navigation>(context, listen: false).getPage(const NotesView());

                      Provider.of<FilterState>(context, listen: false).toggleShowFavouritesOnly();
                    }, 'Bookmarks'),

                    const Gap(35),
      
                    _buildIconButton(LucideIcons.settings, 21, () {
                      Provider.of<Navigation>(context, listen: false).getPage(const Settings());
                    }, 'Settings'),
                  ],
                ),
      
                Column(
                  children: [
                    _buildIconButton(LucideIcons.trash, 21, (){
                        SnackBarUtils.showSnackbar(context, LucideIcons.badgeAlert, "This feature is under development.");
                      }, 'Trash'),
      
                    const Gap(35),
      
                      _buildIconButton(LucideIcons.messageCircle, 21, (){
                        _openAIChat(context);
                      }, 'Ask AI'),
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, double size, VoidCallback onTap, String tooltip, {Color? color}) {
    return Tooltip(

      message: tooltip,

      child: InkWell(
        onTap: onTap,
      
        hoverColor: Colors.transparent,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      
        child: Icon(
          icon,
          size: size,
          color: color ?? Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
        ),
      ),
    );
  }

  // ignore: unused_element
  void _navigateTo(BuildContext context, Widget view) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 300),
        child: view,
      ),
    );
  }

  void _openAIChat(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,

      barrierDismissible: false,

      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12),
          
          child: Dialog(

            surfaceTintColor: Colors.transparent,

            elevation: 0,

            shadowColor: Colors.transparent,

            alignment: Alignment.centerLeft,
            
            backgroundColor: Theme.of(context).colorScheme.primary,
          
            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.circular(10),

              side: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))
            ),
            child: const AIChatInterface(),
          ),
        );
      },
    );
  }
}

class AIChatInterface extends StatefulWidget {
  const AIChatInterface({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AIChatInterfaceState createState() => _AIChatInterfaceState();
}

class _AIChatInterfaceState extends State<AIChatInterface> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late GenerativeModel model;
  final List<String> _conversationHistory = [];

  @override
  void initState() {
    super.initState();
    // Initialize the model with the API key from AppState
    final apiKey = Provider.of<AppState>(context, listen: false).apiKey;
    model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FilledButton(onPressed: (){
                    }, style: ButtonStyle(
                                                        
                    side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
                                                                                      
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor:  MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text('Raya', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),

                    const Gap(10),

                    FilledButton(onPressed: (){
                      SnackBarUtils.showSnackbar(context, CupertinoIcons.ellipsis, 'Open the settings and add the Google API key');
                    }, style: ButtonStyle(
                                                          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
                                                                                  
                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text('APIs', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary))),
                  ],
                ),


                Row(
                  children: [

                    FilledButton(onPressed: (){
                      setState(() {
                        _messages.clear();
                      });
                    }, style: ButtonStyle(
                                                        
                    side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
                                                                                      
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text('Clear', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),

                    const Gap(10),

                    InkWell(

                      overlayColor: const MaterialStatePropertyAll(Colors.transparent),

                      hoverColor: Colors.transparent,
                      
                      onTap: () => Navigator.pop(context), child: Tooltip(message: 'Close', child: Icon(CupertinoIcons.xmark_circle_fill, size: 22, color: Colors.red.withOpacity(0.9))))
                  ],
                ),
  
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(message: message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask...',

                      border: InputBorder.none,

                      hintStyle: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),
                    ),

                    style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),

                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text;
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
      _messageController.clear();
    });

    _scrollToBottom();

    try {
      _conversationHistory.add("User: $userMessage");

      final prompt = _conversationHistory.join('\n');
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text != null && response.text!.isNotEmpty) {
        setState(() {
          _messages.add(ChatMessage(text: response.text!, isUser: false));
        });
        _conversationHistory.add(response.text!);
      } else {
        setState(() {
          _messages.add(ChatMessage(text: "Sorry, I couldn't process that request. Please try again.", isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: '''An error occurred. Please try again.
- Check your internet connection.
- Open settings and check APIs

Get the API key from [ai.google.dev](ai.google.dev).''', isUser: false));
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: message.isUser
                ? (Theme.of(context).colorScheme.background)
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),

            border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))
          ),
          child: !message.isUser ? Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
                
              MarkdownBody(selectable: true,
                  
                    data: message.text,
                    
                    softLineBreak: true,
                  
                    styleSheet: MarkdownStyleSheet(
              
              a: const TextStyle(color: Color.fromARGB(255, 20, 53, 186), height: 1.6),
              
              codeblockDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.9))),

              code: TextStyle(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.4), color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), fontFamily: 'Roboto Mono', fontSize: 14),
              
              p: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6),
              
              textScaler: const TextScaler.linear(1.1),
              
              h2: const TextStyle(fontSize: 17),
              
              h1: Theme.of(context).textTheme.titleLarge,
              
              h3: const TextStyle(fontSize: 16),
              
              tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondary, width: 1),
              
              tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              
              tableBody: const TextStyle(fontSize: 13),
              
              blockquoteDecoration: BoxDecoration(
                
                color:  Theme.of(context).colorScheme.primary.withOpacity(0.9),
              
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              
              blockquotePadding: const EdgeInsets.all(20),
              
              blockquote: const TextStyle(fontSize: 16),
              
              horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),
              
              strong: const TextStyle(fontWeight: FontWeight.w500), 
              
              em: const TextStyle(fontStyle: FontStyle.italic),
              ), extensionSet: md.ExtensionSet(
                [
                  LatexBlockSyntax(),
                  const md.FencedCodeBlockSyntax(),
                  const md.AlertBlockSyntax(),
                ],
                [
                  LatexInlineSyntax(),
                  md.InlineHtmlSyntax(),
                  HighlightSyntax(),
                  md.EmojiSyntax(),
                  md.StrikethroughSyntax(),
                ],
              )),

              const Gap(10),

              IconButton(
                icon:  const Icon(LucideIcons.copy, size: 18),
              onPressed: () => {
                copyToClipboard(context, message.text)
              },
                color: Theme.of(context).colorScheme.tertiary,

                style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),
              ),
            ],
          )
        : Text(message.text, style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 16))), 
      ),
    );
  }
}
