import 'package:flutter/material.dart';
import '../../../../config/themes/common_styles.dart';


class ChattingPage extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class Conversation {
  final String name;
  final String lastMessage;
  final DateTime time;
  final List<Message> _messages = [];

  Conversation({
    required this.name,
    required this.lastMessage,
    required this.time,
  });
  List<Message> get messages => _messages;
}

class Message {
  final String text;
  final DateTime time;
  final bool isSentByMe;

  Message({required this.text, required this.time, required this.isSentByMe});

  bool get isMe => isSentByMe;
}

class _ContactsState extends State<ChattingPage> {
  String _searchText = '';

  void _onTextChanged(String value) {
    setState(() {
      _searchText = value;
    });
  }

  List<Conversation> get filteredConversations {
    if (_searchText.isEmpty) {
      return conversations;
    }
    return conversations
        .where((conversation) =>
        conversation.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  List<Conversation> conversations = [
    Conversation(
      name: 'Dr.Khalid Aljaser',
      lastMessage: 'Fine, but you gotta...',
      time: DateTime.now(),
    ),
    Conversation(
      name: 'Reda Almeshari',
      lastMessage: 'How are you?',
      time: DateTime.now(),
    ),
    Conversation(
      name: 'Adham Almansour',
      lastMessage: 'Nice to meet you',
      time: DateTime.now(),
    ),
    Conversation(
      name: 'Mohhammad Alowa',
      lastMessage: 'See you later',
      time: DateTime.now(),
    ),
    Conversation(
      name: 'Khalid Alabaas',
      lastMessage: 'Goodbye',
      time: DateTime.now(),
    ),
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 67,
            padding: const EdgeInsets.all(13),
            decoration: primary_decoration,
            child: TextField(
              // Use TextField instead of CustomTextField
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onChanged: _onTextChanged,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: primary_decoration,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredConversations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(filteredConversations[index].name[0]),
                    ),
                    title: Text(filteredConversations[index].name),
                    subtitle: Text(filteredConversations[index].lastMessage),
                    trailing: Text(
                      '${filteredConversations[index].time.hour}:${filteredConversations[index].time.minute}',
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ChattingPage(),
                    //     ),
                    //   );
                    // },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


