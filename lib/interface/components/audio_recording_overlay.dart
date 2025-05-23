import 'package:flutter/material.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';

class AudioRecordingOverlay extends StatelessWidget {
  final bool isRecording;
  final Duration recordingDuration;
  final bool isLocked;
  final VoidCallback onCancel;
  final VoidCallback onLock;

  const AudioRecordingOverlay({
    Key? key,
    required this.isRecording,
    required this.recordingDuration,
    required this.isLocked,
    required this.onCancel,
    required this.onLock,
  }) : super(key: key);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (!isRecording) return const SizedBox.shrink();

    return Material(
      child: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mic,
                        color: kPrimaryColor,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _formatDuration(recordingDuration),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                          size: 30,
                        ),
                        onPressed: onCancel,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: Icon(
                          isLocked ? Icons.lock : Icons.lock_open,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                        onPressed: onLock,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Slide up to lock',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
