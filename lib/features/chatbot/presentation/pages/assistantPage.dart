import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../profile/presentation/pages/PersonalInfo.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../data/models/chatMessage_model.dart';
import 'chat_message.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
as authDI;

const String openAi_token = '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';


class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

// make chatbot assistant using openAI
class _AssistantPageState extends State<AssistantPage>{

  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  final authBloc = authDI.sl.get<AuthBloc>();


  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: const Color.fromRGBO(10, 44, 64, 1),
        title: const Text(
          'Samla\'s assistant',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        toolbarHeight: 30,
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          duration: const Duration(seconds: 10),
          reverse: true,
          animateAlignments: true,
          primaryColors: [
            themeBlue,
            Colors.blueAccent,
          ],
          secondaryColors: [
            themeBlue,
            const Color.fromARGB(255, 120, 90, 255),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(64, 194, 210, 1),
                  backgroundColor: Color.fromRGBO(213, 20, 122, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: Colors.transparent,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(10, 44, 64, 1),
          ),
          onPressed: () async {
            setState(
                  () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            generateResponse(input,_messages).then((value) {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            });
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.black),
        controller: _textController,
        decoration: const InputDecoration(
          hintText: 'Ask Samla\'s assistant',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }



}




