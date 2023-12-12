import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/image_helper.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/friends/chat_di.dart';
import 'package:samla_app/features/friends/presentation/cubit/friendShip/friend_ship_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/messages/messages_cubit.dart';
import 'package:samla_app/features/profile/presentation/pages/PersonalInfo.dart';

import '../../../../core/widgets/image_viewer.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/message.dart';
import 'FriendProfilePage.dart';

class ChatPage extends StatefulWidget {
  final int friendUserID;
  final User friend;
  bool showRejection;
  ChatPage(
      {super.key,
      required this.friendUserID,
      required this.friend,
      this.showRejection = true});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final thisUserID = int.parse(sl<AuthBloc>().user.id!);

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final TextEditingController _messageController = TextEditingController();

  late BuildContext gContext;

  @override
  Widget build(BuildContext context) {
    print('this is friend  id ${widget.friendUserID} , this is user id $thisUserID');
    gContext = context;
    final messagesCubit = sl<MessagesCubit>();
    final statusCubit = sl<FriendShipCubit>()..getStatus(widget.friendUserID);
    final friendCubit = sl<FriendCubit>();
    // Replace with your image URL
    //frint has these
    // print(friend.id);
    // print(friend.name);
    // print(friend.email);
    // print(friend.image);
    // print(friend.photoUrl);

    // Function to build AppBar with user's profile and name
    AppBar _buildAppBar(user) {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: ImageViewer.network(
                  placeholderImagePath: 'images/defaults/user.png',
                  imageURL: user.photoUrl ?? '',
                  // Use empty string as default if photoUrl is null
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            SizedBox(width: 10),
            // Space between image and name
            InkWell(
              onTap: () {
                // Navigate to the friend's profile page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FriendProfilePage(),
                  ),
                );
              },
              child: Text(
                user.name ?? '',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        // gradient:
        backgroundColor: themeDarkBlue.withOpacity(.8),
        iconTheme: IconThemeData(color: Colors.white),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(widget.friend),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/defaults/chat_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<FriendShipCubit, FriendShipState>(
          bloc: statusCubit,
          builder: (context, state) {
            if (state is FriendShipLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FriendShipError) {
              return Center(child: Text(state.message));
            } else if (state is FriendShipLoaded) {
              return _buildChatInterface(
                  state, context, friendCubit, messagesCubit);
            }
            return Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }

  Widget _buildChatInterface(FriendShipLoaded state, BuildContext context,
      FriendCubit friendCubit, MessagesCubit messagesCubit) {
    return Column(
      children: [
        () {
          if (state.status.status == 'pending' &&
              widget.showRejection &&
              state.status.userId != thisUserID) {
            print(widget.showRejection);
            return _buildFriendRequestButtons(
                context, state.status.id, friendCubit);
          }
          return Container();
        }(),
        SizedBox(
          height: 10,
        ),
        Expanded(child: _buildMessagesSection(messagesCubit, state.status.id)),
        _buildMessageInputField(
            messagesCubit, _messageController, state.status.id, context),
      ],
    );
  }

  Widget _buildFriendRequestButtons(
      BuildContext context, int friendRequestId, FriendCubit friendCubit) {
    return Container(
      decoration: primaryDecoration,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Text('This user wants to be your friend', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          SizedBox(height: 20,),
          Container
          (
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeBlue,
            ),
            width: double.maxFinite,
            height: 50,
            child: TextButton(
              onPressed: () async {
                await friendCubit.acceptFriend(friendRequestId);
                setState(() {
                  widget.showRejection = false;
                });
                // Additional logic if needed
              },
              child: Text('Accept', style: TextStyle(color: Colors.white)),
             
            ),
          ),
          SizedBox(
            height: 10),
          Container(
            width: double.infinity,
            height: 50,
            // border radius
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeRed,
            ),
            child: TextButton(
              onPressed: () async {
                await friendCubit.rejectFriend(friendRequestId);
                Navigator.pop(context);
              },
              child: Text('Reject', style: TextStyle(color: Colors.white)),
              
            ),
          ),
        ],
      ),
    );
  }

  // still not done with the ui i just want to see if it works ;)
  Widget _buildMessagesSection(MessagesCubit messagesCubit, int friendID) {
    ScrollController _scrollController = ScrollController();
    bool isMessagesWorks = false;

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (isMessagesWorks) {
        messagesCubit.getMessages(friend_id: friendID);
        print('retrive messages: from ${widget.friend.name}');
      }
    });

    return BlocBuilder<MessagesCubit, MessagesState>(
      bloc: messagesCubit..getMessages(friend_id: friendID),
      buildWhen: (previous, current) => true,
      builder: (context, messagesState) {
        print('update states');
        if (messagesState is MessagesLoaded) {
          isMessagesWorks = true;
          

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
                // curve: Curves.easeOut,
                // duration: const Duration(milliseconds: 000),
              );
            }
          });
          // if not empty print last message

          // Build the messages list
          return Container(
            child: LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                controller: _scrollController,
                itemCount: messagesCubit.messages.length,
                itemBuilder: (context, index) {
                  final message = messagesCubit.messages[index];
                  // Add message list item UI
                  return MessageWidget(message, constraints);
                },
              ),
            ),
          );
        } else if (messagesState is MessagesError) {
          return Center(child: Text(messagesState.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget MessageWidget(Message message, constraints) {
    final align = message.sender_id != thisUserID
        ? Alignment.centerLeft
        : Alignment.centerRight;

    return Align(
      alignment: align,
      child: SizedBox(
        // width: ,
        child: Container(
            constraints: BoxConstraints(
                minWidth: 80, maxWidth: constraints.maxWidth * 0.7),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            // change border according to user sender
            decoration: BoxDecoration(
              //box shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 13,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: message.sender_id != thisUserID
                    ? Radius.circular(0)
                    : Radius.circular(10),
                bottomRight: message.sender_id != thisUserID
                    ? Radius.circular(10)
                    : Radius.circular(0),
              ),
              color: message.sender_id != thisUserID
                  ? Colors.white
                  : themeDarkBlue.withOpacity(0.8),
            ),
            child: Stack(children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.type == 'both')
                    message.imageFile != null
                        ? ImageViewer.file(
                            isRectangular: true,
                            imageFile: message.imageFile!,
                            width: constraints.maxWidth * 0.7,
                            height: constraints.maxWidth * 0.7,
                          )
                        : ImageViewer.network(
                            isRectangular: true,
                            imageURL: message.imageURL ?? '',
                            width: constraints.maxWidth * 0.7,
                            height: constraints.maxWidth * 0.7,
                          ),
                  if (message.type == 'both')
                    SizedBox(
                      height: 10,
                    ),
                  Text(message.message.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: message.sender_id != thisUserID
                              ? Colors.black
                              : Colors.white),
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Positioned(
                child: message.created_at != 'pending'
                    ? Text(
                        formatDate(message.created_at.toString()),
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade500),
                        textAlign: message.sender_id != thisUserID
                            ? TextAlign.left
                            : TextAlign.right,
                      )
                    : Icon(
                        Icons.access_time,
                        color: Colors.grey.shade500,
                        size: 13,
                      ),
                bottom: 0,
                right: 0,
              ),
            ])),
      ),
    );
  }

  String formatDate(date) {
    final dateObject = DateTime.parse(date);
    // if same less than 24 hours show time only
    if (dateObject.difference(DateTime.now()).inHours < 24) {
      return '${DateFormat('hh:mma').format(DateTime.parse(date))}';
    }

    return '${DateFormat('yy/MM/dd').format(DateTime.parse(date))}';
  }

  Widget _buildMessageInputField(MessagesCubit messagesCubit,
      TextEditingController messageController, int friendID, _context) {
    return Container(
      //top border
      decoration: BoxDecoration(
        color: themeDarkBlue.withOpacity(0.9),
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Completer<File> completer = Completer();
              // File? image;
              ImageHelper helper = ImageHelper();
              helper.pickImage(_context, (image) {
                if (image != null) {
                  print('image selected');
                  completer.complete(image);
                  // show dialog with image and input to add caption
                }
              });
              completer.future.then((image) {
                addCaptionDialog(_context, messageController, messagesCubit,
                    friendID, image, MediaQuery.of(_context).size.width);
              });
            },
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: SafeArea(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                messagesCubit.sendMessage(
                  Message(
                      sender_id: thisUserID,
                      friend_id: friendID,
                      message: messageController.text,
                      type: 'text',
                      created_at: 'pending'),
                );
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> addCaptionDialog(
      context,
      TextEditingController messageController,
      MessagesCubit messagesCubit,
      int friendID,
      File image,
      width) async {
    print('add caption dialog');
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(15),
            backgroundColor: themeDarkBlue.withOpacity(0.8),
            // title: Text('Add Caption'),

            content: SingleChildScrollView(
              child: SizedBox(
                height: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageViewer.file(
                      isRectangular: true,
                      imageFile: image,
                      width: 300,
                      height: 300,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: SafeArea(
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: "Type a caption",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (messageController.text.isNotEmpty) {
                                Navigator.pop(context);
                                messagesCubit.sendMessage(
                                  Message(
                                      sender_id: thisUserID,
                                      friend_id: friendID,
                                      message: messageController.text,
                                      type: messageController.text.isNotEmpty
                                          ? 'both'
                                          : 'image',
                                      created_at: 'pending',
                                      imageFile: image),
                                );
                                messageController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // actions: [
            //   TextButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       child: Text('Cancel', style: TextStyle(color: Colors.grey))),
            //   TextButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //         messagesCubit.sendMessage(
            //           Message(
            //               sender_id: thisUserID,
            //               friend_id: friendID,
            //               message: messageController.text,
            //               type: 'both',
            //               created_at: DateTime.now().toString(),
            //               imageFile: image),
            //         );
            //       },
            //       child: Text('Send', style: TextStyle(color: Colors.white))),
            // ],
          );
        });
  }
}
