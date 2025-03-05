 // import 'package:dash_chat_2/dash_chat_2.dart';
 // import 'package:flutter/material.dart';
 // import 'package:flutter_gemini/flutter_gemini.dart';


 // class ChatPage extends StatefulWidget {
 //   const ChatPage({super.key});
 //
 //   @override
 //   State<ChatPage> createState() => _ChatPageState();
 // }
 //
 // class _ChatPageState extends State<ChatPage> {
 //   final Gemini panda = Gemini.instance; // Changed variable name from gemini to panda
 //   List<ChatMessage> messages = [];
 //
 //   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
 //   ChatUser pandaUser = ChatUser(
 //     id: "1",
 //     firstName: "Panda",
 //     profileImage:
 //     "https://thumbs.dreamstime.com/z/cute-chibi-panda-exploring-tiny-backpack-charming-illustration-features-nature-surrounded-vibrant-flowers-350550169.jpg?ct=jpeg",
 //   );
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     return Scaffold(
 //       appBar: AppBar(
 //         centerTitle: true,
 //         title: const Text("Panda"),
 //       ),
 //       body: _buildUI(),
 //     );
 //   }
 //
 //   Widget _buildUI() {
 //     return DashChat(
 //       currentUser: currentUser,
 //       inputOptions: InputOptions(),
 //       onSend: _sendMessage,
 //       messages: messages,
 //     );
 //   }
 //
 //   void _sendMessage(ChatMessage chatMessage) {
 //     setState(() {
 //       messages = [chatMessage, ...messages];
 //     });
 //     try {
 //       String question = chatMessage.text.toLowerCase();
 //
 //       // Check for name-related or greeting messages
 //       if (question.contains("what is your name") ||
 //           question.contains("who are you") ||
 //           question.contains("hi panda")||
 //           question.contains("hello panda")||
 //           question.contains("hey panda")) {
 //         ChatMessage responseMessage = ChatMessage(
 //           user: pandaUser,
 //           createdAt: DateTime.now(),
 //           text: "I'm Panda! How can I help you?",
 //         );
 //         setState(() {
 //           messages = [responseMessage, ...messages];
 //         });
 //       } else {
 //         // If no specific match, proceed to generate content
 //         panda.streamGenerateContent(question).listen((event) {
 //           ChatMessage? lastMessage = messages.firstOrNull;
 //           if (lastMessage != null && lastMessage.user == pandaUser) {
 //             lastMessage = messages.removeAt(0);
 //             String response = event.content?.parts?.fold(
 //               "",
 //                   (previous, current) => "$previous ${current.text}",
 //             ) ??
 //                 "";
 //             lastMessage.text += response;
 //             setState(() {
 //               messages = [lastMessage!, ...messages];
 //             });
 //           } else {
 //             String response = event.content?.parts?.fold(
 //               "",
 //                   (previous, current) => "$previous ${current.text}",
 //             ) ??
 //                 "";
 //             ChatMessage message = ChatMessage(
 //               user: pandaUser,
 //               createdAt: DateTime.now(),
 //               text: response,
 //             );
 //             setState(() {
 //               messages = [message, ...messages];
 //             });
 //           }
 //         });
 //       }
 //     } catch (e) {
 //       print(e);
 //     }
 //   }
 // }
 // import 'package:dash_chat_2/dash_chat_2.dart';
 // import 'package:flutter/material.dart';
 // import 'package:flutter_gemini/flutter_gemini.dart';
 //
 // class ChatPage extends StatefulWidget {
 //   const ChatPage({super.key});
 //
 //   @override
 //   State<ChatPage> createState() => _ChatPageState();
 // }
 //
 // class _ChatPageState extends State<ChatPage> {
 //   final Gemini panda = Gemini.instance; // Changed variable name from gemini to panda
 //   List<ChatMessage> messages = [];
 //
 //   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
 //   ChatUser pandaUser = ChatUser(
 //     id: "1",
 //     firstName: "Panda",
 //     profileImage:
 //     "https://thumbs.dreamstime.com/z/cute-chibi-panda-exploring-tiny-backpack-charming-illustration-features-nature-surrounded-vibrant-flowers-350550169.jpg?ct=jpeg",
 //   );
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     return Scaffold(
 //       appBar: AppBar(
 //         centerTitle: true,
 //         title: const Text("Panda"),
 //       ),
 //       body: _buildUI(),
 //     );
 //   }
 //
 //   Widget _buildUI() {
 //     return DashChat(
 //       currentUser: currentUser,
 //       inputOptions: InputOptions(),
 //       onSend: _sendMessage,
 //       messages: messages,
 //     );
 //   }
 //
 //   void _sendMessage(ChatMessage chatMessage) {
 //     setState(() {
 //       messages = [chatMessage, ...messages];
 //     });
 //     try {
 //       String question = chatMessage.text.toLowerCase();
 //
 //       // Check for name-related or greeting messages
 //       if (question.contains("what is your name") ||
 //           question.contains("who are you") ||
 //           question.contains("hi panda") ||
 //           question.contains("hello panda") ||
 //           question.contains("hey panda")) {
 //         ChatMessage responseMessage = ChatMessage(
 //           user: pandaUser,
 //           createdAt: DateTime.now(),
 //           text: "I'm Panda! How can I help you?",
 //         );
 //         setState(() {
 //           messages = [responseMessage, ...messages];
 //         });
 //       } else {
 //         // If no specific match, proceed to generate content
 //         panda.streamGenerateContent(question).listen((event) {
 //           ChatMessage? lastMessage = messages.firstOrNull;
 //           if (lastMessage != null && lastMessage.user == pandaUser) {
 //             lastMessage = messages.removeAt(0);
 //             String response = event.content?.parts?.fold(
 //               "",
 //                   (previous, current) => "$previous ${current.text}",
 //             ) ??
 //                 "";
 //             lastMessage.text += _stripMarkdown(response);
 //             setState(() {
 //               messages = [lastMessage!, ...messages];
 //             });
 //           } else {
 //             String response = event.content?.parts?.fold(
 //               "",
 //                   (previous, current) => "$previous ${current.text}",
 //             ) ??
 //                 "";
 //             ChatMessage message = ChatMessage(
 //               user: pandaUser,
 //               createdAt: DateTime.now(),
 //               text: _stripMarkdown(response),
 //             );
 //             setState(() {
 //               messages = [message, ...messages];
 //             });
 //           }
 //         });
 //       }
 //     } catch (e) {
 //       print(e);
 //     }
 //   }
 //
 //   // Helper function to remove markdown formatting
 //   String _stripMarkdown(String text) {
 //     final markdownRegex = RegExp(r'(\*\*|__|_|\*|`|~|>)');
 //     return text.replaceAll(markdownRegex, '');
 //   }
 // }
 import 'package:dash_chat_2/dash_chat_2.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_gemini/flutter_gemini.dart';

 class ChatPage extends StatefulWidget {
   const ChatPage({super.key});

   @override
   State<ChatPage> createState() => _ChatPageState();
 }

 class _ChatPageState extends State<ChatPage> {
   final Gemini panda = Gemini.instance; // Changed variable name from gemini to panda
   List<ChatMessage> messages = [];

   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
   ChatUser pandaUser = ChatUser(
     id: "1",
     firstName: "Panda",
     profileImage:
     "https://thumbs.dreamstime.com/z/cute-chibi-panda-exploring-tiny-backpack-charming-illustration-features-nature-surrounded-vibrant-flowers-350550169.jpg?ct=jpeg",
   );

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: const Text("Panda"),
       ),
       body: _buildUI(),
     );
   }

   Widget _buildUI() {
     return DashChat(
       currentUser: currentUser,
       inputOptions: InputOptions(),
       onSend: _sendMessage,
       messages: messages,
     );
   }

   void _sendMessage(ChatMessage chatMessage) {
     setState(() {
       messages = [chatMessage, ...messages];
     });
     try {
       String question = chatMessage.text.toLowerCase();

       // Academic specialization logic
       if (question.contains("what is your name") ||
           question.contains("who are you") ||
           question.contains("hi panda") ||
           question.contains("hello panda") ||
           question.contains("hey panda")) {
         _sendResponse("I'm Panda! Your academic assistant. How can I help you?");
       } else if (question.contains("timetable") ||
           question.contains("schedule")) {
         _sendResponse(
             "Sure! Please tell me which class or course you're studying, and I'll create a timetable for you.");
       } else if (question.contains("assignment")) {
         _sendResponse(
             "Let me know the subject and due date of your assignment. I can help you plan!");
       } else if (question.contains("exam date")) {
         _sendResponse(
             "Which exam are you referring to? I can help track the dates for you.");
       } else if (question.contains("study tips")) {
         _sendResponse(
             "Here are some study tips:\n1. Create a dedicated study space.\n2. Break study sessions into chunks (Pomodoro).\n3. Use active recall and spaced repetition.\n4. Take regular breaks.");
       } else if (question.contains("stress management")) {
         _sendResponse(
             "To manage stress, try these tips:\n1. Take deep breaths and meditate.\n2. Exercise regularly.\n3. Get enough sleep.\n4. Break tasks into smaller steps.");
       } else if (question.contains("class") || question.contains("course")) {
         _sendResponse(
             "Please share which class or course you're studying, and I'll assist you accordingly.");
       } else {
         // If no specific match, proceed to generate content
         panda.streamGenerateContent(question).listen((event) {
           String response = event.content?.parts?.fold(
             "",
                 (previous, current) => "$previous ${current.text}",
           ) ??
               "";
           _sendResponse(_stripMarkdown(response));
         });
       }
     } catch (e) {
       print(e);
     }
   }

   // Helper function to send a response
   void _sendResponse(String response) {
     ChatMessage responseMessage = ChatMessage(
       user: pandaUser,
       createdAt: DateTime.now(),
       text: response,
     );
     setState(() {
       messages = [responseMessage, ...messages];
     });
   }

   // Helper function to remove markdown formatting
   String _stripMarkdown(String text) {
     final markdownRegex = RegExp(r'(\*\*|__|_|\*|`|~|>)');
     return text.replaceAll(markdownRegex, '');
   }
 }

