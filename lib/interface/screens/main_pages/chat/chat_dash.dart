import 'package:dubaiprojectxyvin/interface/Data/models/chat_model.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class ChatDash extends ConsumerStatefulWidget {
  ChatDash({super.key});

  @override
  ConsumerState<ChatDash> createState() => _ChatDashState();
}

class _ChatDashState extends ConsumerState<ChatDash> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
List<ChatModel> chats = [
  ChatModel(
    id: "chat1",
    participants: [
      Participant(id: "user1", name: "Alice", image: "https://example.com/alice.jpg"),
      Participant(id: "user2", name: "Bob", image: "https://example.com/bob.jpg"),
    ],
    lastMessage: LastMessage(
      id: "msg1",
      from: "user1",
      to: "user2",
      content: "Hey, how are you?",
      status: "sent",
      createdAt: DateTime.now().subtract(Duration(minutes: 5)),
      updatedAt: DateTime.now().subtract(Duration(minutes: 4)),
      v: 0,
    ),
    unreadCount: {"user2": 1},
    isGroup: false,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    updatedAt: DateTime.now(),
    v: 1,
  ),
  ChatModel(
    id: "chat2",
    participants: [
      Participant(id: "user3", name: "Charlie", image: "https://example.com/charlie.jpg"),
      Participant(id: "user4", name: "Dana", image: "https://example.com/dana.jpg"),
    ],
    lastMessage: LastMessage(
      id: "msg2",
      from: "user4",
      to: "user3",
      content: "See you tomorrow!",
      status: "delivered",
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(Duration(hours: 1)),
      v: 0,
    ),
    unreadCount: {"user3": 0, "user4": 0},
    isGroup: false,
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    updatedAt: DateTime.now(),
    v: 1,
  ),
  ChatModel(
    id: "chat3",
    participants: [
      Participant(id: "user5", name: "Eve", image: "https://example.com/eve.jpg"),
      Participant(id: "user6", name: "Frank", image: "https://example.com/frank.jpg"),
      Participant(id: "user7", name: "Grace", image: "https://example.com/grace.jpg"),
    ],
    lastMessage: LastMessage(
      id: "msg3",
      from: "user5",
      to: "user6",
      content: "Group chat started",
      status: "read",
      createdAt: DateTime.now().subtract(Duration(minutes: 30)),
      updatedAt: DateTime.now().subtract(Duration(minutes: 25)),
      v: 0,
    ),
    unreadCount: {"user6": 2, "user7": 2},
    isGroup: true,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    updatedAt: DateTime.now(),
    v: 1,
  ),
];

// final asyncChats = ref.watch(fetchChatThreadProvider);
      return Scaffold(
          backgroundColor: Colors.white,
          body: 
              // if (chats.isNotEmpty) {
                 ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    var receiver = chats[index].participants?.firstWhere(
                          (participant) => participant.id != 'user1',
                          orElse: () => Participant(),
                        );
                    var sender = chats[index].participants?.firstWhere(
                          (participant) => participant.id == 'user1',
                          orElse: () => Participant(),
                        );
                    return Column(
                      children: [
                        ListTile(
                          leading: ClipOval(
                            child: Container(
                              width: 40,
                              height: 40,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Image.network(
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }

                                  return Container(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                receiver?.image ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return SvgPicture.asset(
                                      'assets/svg/icons/dummy_person_small.svg');
                                },
                              ),
                            ),
                          ),
                          title: Text('${receiver?.name ?? ''}'),
                          subtitle: Text(
                            chats[index].lastMessage?.content != null
                                ? (chats[index].lastMessage!.content!.length >
                                        10
                                    ? '${chats[index].lastMessage?.content!.substring(0, chats[index].lastMessage!.content!.length.clamp(0, 10))}...'
                                    : chats[index].lastMessage!.content!)
                                : '',
                          ),
                          trailing: chats[index].unreadCount?[sender?.id] !=
                                      0 &&
                                  chats[index].unreadCount?[sender!.id] != null
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Center(
                                      child: chats[index]
                                                  .unreadCount?[sender!.id] !=
                                              null
                                          ? Text(
                                              '${chats[index].unreadCount?[sender!.id]}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          : null,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => IndividualPage(
                                receiver: receiver!,
                                sender: sender!,
                              ),
                            ));
                          },
                        ),
                        Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.grey[350]), // Full-width divider line
                      ],
                    );
                  },
                )
              // } else {
              //   return Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child:
              //             Center(child: Image.asset('assets/pngs/nochat.png')),
              //       ),
              //       Text('No chat yet!')
              //     ],
              //   );
              // }
 
          );
    });
  }
}
