import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/markdown/syntax.dart';
import 'package:ozan/views/Journal/journal_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Ensure to replace with your actual API key
const apiKey = 'AIzaSyDS08hZlaB5hJfRUi8SyyX9iOZ9Z69uadY';

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildIconButton(Iconsax.home_2_copy, 23, () {}),
                  const Gap(33),
                  _buildIconButton(Iconsax.hierarchy_copy, 21, () {}),
                  const Gap(35),
                  _buildIconButton(Iconsax.note_2_copy, 23, () => {}),
                  const Gap(33),
                  _buildIconButton(Iconsax.heart_copy, 23, () => _navigateTo(context, const JournalView())),
                ],
              ),
              IconButton(
                icon:  const Icon(FluentIcons.sparkle_32_regular, size: 26),
                onPressed: () => _openAIChat(context),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.8)
                    : Colors.blue.shade900,

                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.5) : Theme.of(context).colorScheme.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, double size, VoidCallback onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: size,
        color: color ?? Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
      ),
    );
  }

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
            
            backgroundColor: Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 249, 253, 255) : Theme.of(context).colorScheme.primary,
          
            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.circular(20),

              side: BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)
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
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );
  final List<String> _conversationHistory = [];

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
                FilledButton(onPressed: (){
              }, style: ButtonStyle(
                                                    
                side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                                                  
                padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary)), child: Row(

                  children: [
                    Text('Ask Caira', style: TextStyle(fontSize: 18, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),

                    const Gap(10),

                    Icon(CupertinoIcons.question_circle, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, size: 22)
                  ],
                )),

                Row(
                  children: [

                    FilledButton(onPressed: (){
                      setState(() {
                        _messages.clear();
                      });
                                  }, style: ButtonStyle(
                                                        
                    side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                                                      
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary)), child: Row(
                    
                      children: [
                        
                        Icon(FluentIcons.sparkle_28_regular, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, size: 24),
                    
                        const Gap(10),
                    
                        Text('New Chat', style: TextStyle(fontSize: 18, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                      ],
                    )),

                    const Gap(10),

                    IconButton(
                      icon:  const Icon(CupertinoIcons.xmark, size: 18),
                    onPressed: () => {
                      Navigator.pop(context)
                    },
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.tertiary.withOpacity(0.8)
                          : Colors.blue.shade900,

                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.2) : Theme.of(context).colorScheme.primary), 
                      
                      side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary))),
                    ),
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
                      hintText: 'Ask me anything...',

                      border: InputBorder.none,

                      hintStyle: TextStyle(fontSize: 17, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),
                    ),

                    style: TextStyle(fontSize: 17, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),

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
        _messages.add(ChatMessage(text: "An error occurred. Please try again.", isUser: false));
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
                ? (Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary)
                : Theme.of(context).colorScheme.background.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),

            border: Border.all(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)
          ),
          child: !message.isUser ? Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
                
              MarkdownBody(selectable: true,
                  
                    data: message.text,
                    
                    softLineBreak: true,
                  
                    styleSheet: MarkdownStyleSheet(
              
              a: const TextStyle(color: Color.fromARGB(255, 20, 53, 186), height: 1.6),
              
              codeblockDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.7))),

              code: TextStyle(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.4), color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7), fontFamily: 'Roboto Mono', fontSize: 14),
              
              p: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6),
              
              textScaler: const TextScaler.linear(1.1),
              
              h2: const TextStyle(fontSize: 17),
              
              h1: Theme.of(context).textTheme.titleLarge,
              
              h3: const TextStyle(fontSize: 16),
              
              tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondary, width: 1),
              
              tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              
              tableBody: const TextStyle(fontSize: 13),
              
              blockquoteDecoration: BoxDecoration(
                
                color:  Theme.of(context).colorScheme.primary.withOpacity(0.8),
              
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              
              blockquotePadding: const EdgeInsets.all(20),
              
              blockquote: const TextStyle(fontSize: 16),
              
              horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
              
              strong: const TextStyle(fontWeight: FontWeight.w500), 
              
              em: const TextStyle(fontStyle: FontStyle.italic),
                    )),

              const Gap(10),

              IconButton(
                icon:  const Icon(Iconsax.copy_copy, size: 23),
              onPressed: () => {
                copyToClipboard(context, message.text)
              },
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.8)
                    : Colors.blue.shade900,

                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.2) : Theme.of(context).colorScheme.primary)),
              ),
            ],
          )
        : Text(message.text, style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontSize: 17))), 
      ),
    );
  }
}
