// import 'package:flutter/material.dart';
//
// class ContactsPage extends StatefulWidget {
//   const ContactsPage({Key? key}) : super(key: key);
//
//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }
//
// class _ContactsPageState extends State<ContactsPage> {
//   final _textController = TextEditingController();
//   final List<String> _quickWords = ['Hello', 'Good day!', 'How are you?'];
//   final List<String> _messages = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chatting'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.blue, // You can change the color to your preference
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Text(
//                       _messages[index],
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       hintText: 'Send a message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _handleSubmit(_textController.text);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _handleSubmit(String text) {
//     _textController.clear();
//     setState(() {
//       _messages.add(text);
//     });
//   }
// }