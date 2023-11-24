import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/new_style.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../data/models/chatMessage_model.dart';
import 'chat_message.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;

const String openAiToken =
    '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';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  final authBloc = di.sl.get<AuthBloc>();

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          primaryColors: const [
            themeBlue,
            Colors.blueAccent,
          ],
          secondaryColors: const [
            themeBlue,
            Color.fromARGB(255, 120, 90, 255),
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
                  color: themeBlue,
                  backgroundColor: themePink
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if(!isLoading)
                  _buildInput(),
                  if(!isLoading)
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
            color: themeDarkBlue,
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
            generateResponse(input, _messages).then((value) {
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
        controller: _textController,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: themeDarkBlue),
          hintText: 'Ask Samla\'s assistant',
          filled: true,
          hintStyle: TextStyle(color: themeDarkBlue.withOpacity(0.3)),
          alignLabelWithHint: true,
          focusColor: themeDarkBlue,
          fillColor: themeDarkBlue.withOpacity(0.05),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeDarkBlue.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeDarkBlue.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        style: const TextStyle(color: themeDarkBlue),
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
