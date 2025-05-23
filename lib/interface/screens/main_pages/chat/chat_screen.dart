import 'package:dubaiprojectxyvin/Data/models/chat_model.dart';
import 'package:dubaiprojectxyvin/Data/models/msg_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
import 'package:dubaiprojectxyvin/Data/services/api_routes/chat_api/chat_api.dart';
import 'package:dubaiprojectxyvin/Data/services/image_service.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/dialogs/blockPersonDialog.dart';
import 'package:dubaiprojectxyvin/interface/components/dialogs/report_dialog.dart';
import 'package:dubaiprojectxyvin/interface/components/own_message_card.dart';
import 'package:dubaiprojectxyvin/interface/components/reply_card.dart';
import 'package:dubaiprojectxyvin/interface/components/audio_message_card.dart';
import 'package:dubaiprojectxyvin/interface/screens/profile/profile_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';

import '../../../../Data/services/api_routes/user_api/user_data/user_data.dart';
import 'package:image_picker/image_picker.dart';

// Helper function to check if two DateTimes are on the same day
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

// Widget for displaying date separators
class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({Key? key, required this.date}) : super(key: key);

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(date); // Format for other dates
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            _getDateLabel(date),
            style: const TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ),
    );
  }
}

class IndividualPage extends ConsumerStatefulWidget {
  IndividualPage({required this.receiver, required this.sender, super.key});
  final Participant receiver;
  final Participant sender;
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends ConsumerState<IndividualPage> {
  bool isBlocked = false;
  bool show = false;
  FocusNode focusNode = FocusNode();
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  // Audio recording variables
  final _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  bool _isLocked = false;
  String? _recordingPath;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;

  @override
  void initState() {
    super.initState();
    getMessageHistory();
    _requestPermissions();
  }

  void getMessageHistory() async {
    final messagesette =
        await ChatApiService.getChatBetweenUsers(widget.receiver.id!);
    if (mounted) {
      setState(() {
        messages.addAll(messagesette);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadBlockStatus(); // Now safe to call
  }

  Future<void> _loadBlockStatus() async {
    ref.watch(userProvider).whenData((user) {
      if (mounted) {
        setState(() {
          isBlocked = user.blockedUsers
                  ?.any((blockedUser) => blockedUser == widget.receiver.id) ??
              false;
        });
      }
    });
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      }
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    if (mounted) {
      setState(() {
        _recordingDuration = Duration.zero;
      });
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await Permission.microphone.isGranted) {
        final directory = await getTemporaryDirectory();
        _recordingPath =
            '${directory.path}/audio_message_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: _recordingPath!,
        );

        if (mounted) {
          setState(() {
            _isRecording = true;
            _isLocked = false;
          });
        }
        _startRecordingTimer();
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
      if (mounted) {
        setState(() {
          _isRecording = false;
          _isLocked = false;
        });
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      _stopRecordingTimer();
      if (mounted) {
        setState(() {
          _isRecording = false;
          _isLocked = false;
        });
      }

      if (path != null) {
        final audioFile = File(path);
        if (await audioFile.exists()) {
          await _sendAudioMessage(path);
        } else {
          debugPrint('Recorded file not found at path: $path');
        }
      } else {
        debugPrint('Recording stop returned null path');
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      if (mounted) {
        setState(() {
          _isRecording = false;
          _isLocked = false;
        });
      }
    }
  }

  Future<void> _cancelRecording() async {
    try {
      await _audioRecorder.stop();
      _stopRecordingTimer();
      if (mounted) {
        setState(() {
          _isRecording = false;
          _isLocked = false;
        });
      }
      if (_recordingPath != null) {
        final audioFile = File(_recordingPath!);
        if (await audioFile.exists()) {
          await audioFile.delete();
          debugPrint('Canceled recording file deleted: $_recordingPath');
        }
        _recordingPath = null;
      }
    } catch (e) {
      debugPrint('Error canceling recording: $e');
      if (mounted) {
        setState(() {
          _isRecording = false;
          _isLocked = false;
        });
      }
    }
  }

  Future<void> _sendAudioMessage(String audioPath) async {
    final String audioUrl = await MediaService.audioUpload(audioPath);
    final messageId = await ChatApiService.sendChatMessage(
      Id: widget.receiver.id!,
      content: 'Audio message',
      mediaType: 'audio',
      media: audioUrl,
    );

    if (messageId.isNotEmpty) {
      if (mounted) {
        setMessage("sent", "Audio message", widget.sender.id!,
            media: audioPath, mediaType: 'audio');
      }
    }
  }

  @override
  void dispose() {
    focusNode.unfocus();
    _controller.dispose();
    _scrollController.dispose();
    focusNode.dispose();
    _audioRecorder.dispose();
    _stopRecordingTimer();
    super.dispose();
  }

  void sendMessage() {
    if (_controller.text.isNotEmpty && mounted) {
      ChatApiService.sendChatMessage(
        Id: widget.receiver.id!,
        content: _controller.text,
      );
      setMessage("sent", _controller.text, widget.sender.id!);
      _controller.clear();
    }
  }

  void setMessage(String type, String message, String fromId,
      {String? media, String? mediaType}) {
    final messageModel = MessageModel(
      from: fromId,
      status: type,
      content: message,
      createdAt: DateTime.now(),
      media: media,
      mediaType: mediaType ?? 'text',
    );

    if (mounted) {
      setState(() {
        messages.add(messageModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageStream = ref.watch(messageStreamProvider);

    messageStream.whenData((newMessage) {
      if (mounted) {
        bool messageExists = messages.any((message) =>
            message.createdAt == newMessage.createdAt &&
            message.content == newMessage.content);

        if (!messageExists) {
          setState(() {
            messages.add(newMessage);
          });
        }
      }
    });

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  actions: [
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert), // The three-dot icon
                      onSelected: (value) {
                        if (value == 'report') {
                          showReportPersonDialog(
                            context: context,
                            onReportStatusChanged: () {},
                            reportType: 'User',
                            reportedItemId: widget.receiver.id ?? '',
                          );
                        } else if (value == 'block') {
                          showBlockPersonDialog(
                            context: context,
                            userId: widget.receiver.id ?? '',
                            onBlockStatusChanged: () {
                              Future.delayed(const Duration(seconds: 1), () {
                                if (mounted) {
                                  setState(() {
                                    isBlocked = !isBlocked;
                                  });
                                }
                              });
                            },
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'report',
                          child: Row(
                            children: [
                              Icon(Icons.report, color: kPrimaryColor),
                              SizedBox(width: 8),
                              Text('Report'),
                            ],
                          ),
                        ),
                        // Divider for visual separation
                        const PopupMenuDivider(height: 1),
                        PopupMenuItem(
                          value: 'block',
                          child: Row(
                            children: [
                              Icon(Icons.block),
                              SizedBox(width: 8),
                              isBlocked ? Text('Unblock') : Text('Block'),
                            ],
                          ),
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      offset: const Offset(0, 40),
                    )
                  ],
                  elevation: 1,
                  shadowColor: Colors.white,
                  backgroundColor: Colors.white,
                  leadingWidth: 90,
                  titleSpacing: 0,
                  leading: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Container(
                          width: 30,
                          height: 30,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Image.network(
                            widget.receiver.image ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(
                                  'assets/svg/icons/dummy_person_small.svg');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Consumer(
                    builder: (context, ref, child) {
                      final asyncUser = ref.watch(
                          fetchUserDetailsProvider(widget.receiver.id ?? ''));
                      return asyncUser.when(
                        data: (user) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => ProfilePreview(
                                    user: user,
                                  ),
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  transitionsBuilder: (_, a, __, c) =>
                                      FadeTransition(opacity: a, child: c),
                                ),
                              );
                            },
                            child: Text(
                              user.name ?? '',
                            ),
                          );
                        },
                        loading: () => Text(
                          widget.receiver.name ?? '',
                        ),
                        error: (error, stackTrace) {
                          // Handle error state
                          return const Center(
                            child: Text(
                                'Something went wrong please try again later'),
                          );
                        },
                      );
                    },
                  ),
                )),
            body: Container(
              decoration: const BoxDecoration(color: kFillColor),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PopScope(
                child: Column(
                  children: [
                    Expanded(
                      child: messages.isNotEmpty
                          ? ListView.builder(
                              reverse: true,
                              controller: _scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message =
                                    messages[messages.length - 1 - index];
                                final previousMessage =
                                    index < messages.length - 1
                                        ? messages[messages.length - 2 - index]
                                        : null;

                                final messageDate =
                                    message.createdAt?.toLocal() ??
                                        DateTime.now();
                                final previousMessageDate =
                                    previousMessage?.createdAt?.toLocal() ??
                                        messageDate
                                            .subtract(const Duration(days: 1));

                                final bool showDateSeparator =
                                    previousMessage == null ||
                                        !isSameDay(
                                            messageDate, previousMessageDate);

                                Widget messageWidget;
                                if (message.from == widget.sender.id) {
                                  if (message.mediaType == 'audio') {
                                    messageWidget = AudioMessageCard(
                                      audioUrl: message.media!,
                                      isMe: true,
                                      time: DateFormat('h:mm a')
                                          .format(messageDate),
                                    );
                                  } else {
                                    messageWidget = OwnMessageCard(
                                      media: message.media,
                                      mediaType: message.mediaType,
                                      product: message.product,
                                      requirement: message.feed,
                                      status: message.status!,
                                      message: message.content ?? '',
                                      time: DateFormat('h:mm a')
                                          .format(messageDate),
                                    );
                                  }
                                } else {
                                  if (message.mediaType == 'audio') {
                                    messageWidget = AudioMessageCard(
                                      audioUrl: message.media!,
                                      isMe: false,
                                      time: DateFormat('h:mm a')
                                          .format(messageDate),
                                    );
                                  } else {
                                    messageWidget = GestureDetector(
                                      onLongPress: () {
                                        showReportPersonDialog(
                                            reportedItemId: message.id ?? '',
                                            context: context,
                                            onReportStatusChanged: () {},
                                            reportType: 'Message');
                                      },
                                      child: ReplyCard(
                                        media: message.media,
                                        mediaType: message.mediaType,
                                        product: message.product,
                                        business: message.feed,
                                        message: message.content ?? '',
                                        time: DateFormat('h:mm a')
                                            .format(messageDate),
                                      ),
                                    );
                                  }
                                }

                                return Column(
                                  children: [
                                    if (showDateSeparator)
                                      DateSeparator(date: messageDate),
                                    messageWidget,
                                  ],
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Image.asset(
                                      'assets/png/startConversation.png')),
                            ),
                    ),
                    if (!isBlocked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: Row(
                          children: [
                            if (!_isRecording)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      enableDrag: true,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (builder) => bottomSheet(),
                                    );
                                  },
                                  child: const Icon(Icons.attach_file,
                                      color: Colors.grey),
                                ),
                              ),
                            Expanded(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  const begin = Offset(-1.0, 0.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation =
                                      animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                child: _isRecording
                                    ? Container(
                                        key: const ValueKey<bool>(true),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: _cancelRecording,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _formatDuration(
                                                  _recordingDuration),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(child: Container()),
                                            if (!_isLocked) ...[
                                              const Icon(Icons.lock_open,
                                                  color: Colors.grey),
                                              const SizedBox(width: 8),
                                              const Text(
                                                'Slide up to lock',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ] else ...[
                                              const Text(
                                                'Recording locked',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(width: 8),
                                            ]
                                          ],
                                        ),
                                      )
                                    : Container(
                                        key: const ValueKey<bool>(false),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: _controller,
                                                focusNode: focusNode,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Type a message",
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.send,
                                                  color: kPrimaryColor),
                                              onPressed: sendMessage,
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomCenter,
                              children: [
                                GestureDetector(
                                  onLongPressStart: (_) => _startRecording(),
                                  onLongPressEnd: (_) {
                                    if (!_isLocked) {
                                      _stopRecording();
                                    }
                                  },
                                  onLongPressMoveUpdate: (details) {
                                    if (!_isLocked &&
                                        details.localOffsetFromOrigin.dy <
                                            -50) {
                                      if (mounted) {
                                        setState(() {
                                          _isLocked = true;
                                        });
                                      }
                                      HapticFeedback.vibrate();
                                    }
                                  },
                                  onTap: () {
                                    if (_isLocked) {
                                      _stopRecording();
                                    }
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _isRecording && !_isLocked
                                          ? Colors.red
                                          : kPrimaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isLocked ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (_isRecording && _isLocked)
                                  Positioned(
                                    bottom: 30,
                                    child: Icon(
                                      Icons.lock,
                                      color: kPrimaryColor,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                onPopInvoked: (didPop) {
                  if (didPop) {
                    if (show) {
                      if (mounted) {
                        setState(() {
                          show = false;
                        });
                      }
                    } else {
                      focusNode.unfocus();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      });
                    }
                    ref.invalidate(fetchChatThreadProvider);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 178,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    "Document",
                    onTap: () async {
                      final File? document = await MediaService.pickDocument();
                      if (document != null) {
                        try {
                          final String documentUrl =
                              await MediaService.documentUpload(document.path);
                          final messageId =
                              await ChatApiService.sendChatMessage(
                            Id: widget.receiver.id!,
                            content: 'Document',
                            mediaType: 'document',
                            media: documentUrl,
                          );

                          if (messageId.isNotEmpty && mounted) {
                            setMessage(
                              "sent",
                              "Document",
                              widget.sender.id!,
                              media: documentUrl,
                              mediaType: 'document',
                            );
                          }
                        } catch (e) {
                          debugPrint('Error sending document: $e');
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                    onTap: () async {
                      final XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        try {
                          final String imageUrl =
                              await MediaService.mediaUpload(image.path);
                          final messageId =
                              await ChatApiService.sendChatMessage(
                            Id: widget.receiver.id!,
                            content: 'Image',
                            mediaType: 'image',
                            media: imageUrl,
                          );

                          if (messageId.isNotEmpty && mounted) {
                            setMessage(
                              "sent",
                              "Image",
                              widget.sender.id!,
                              media: imageUrl,
                              mediaType: 'image',
                            );
                          }
                        } catch (e) {
                          debugPrint('Error sending image: $e');
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.video_library,
                    Colors.red,
                    "Video",
                    onTap: () async {
                      final XFile? video = await ImagePicker()
                          .pickVideo(source: ImageSource.gallery);
                      if (video != null) {
                        try {
                          final String videoUrl =
                              await MediaService.videoUpload(video.path);
                          final messageId =
                              await ChatApiService.sendChatMessage(
                            Id: widget.receiver.id!,
                            content: 'Video',
                            mediaType: 'video',
                            media: videoUrl,
                          );

                          if (messageId.isNotEmpty && mounted) {
                            setMessage(
                              "sent",
                              "Video",
                              widget.sender.id!,
                              media: videoUrl,
                              mediaType: 'video',
                            );
                          }
                        } catch (e) {
                          debugPrint('Error sending video: $e');
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              // const SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     iconCreation(
              //       Icons.person,
              //       Colors.blue,
              //       "Contact",
              //       onTap: () {
              //         // TODO: Implement contact sharing
              //         Navigator.pop(context);
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
