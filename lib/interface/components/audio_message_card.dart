import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';

class AudioMessageCard extends StatefulWidget {
  final String audioUrl;
  final bool isMe;
  final String time;

  const AudioMessageCard({
    Key? key,
    required this.audioUrl,
    required this.isMe,
    required this.time,
  }) : super(key: key);

  @override
  State<AudioMessageCard> createState() => _AudioMessageCardState();
}

class _AudioMessageCardState extends State<AudioMessageCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void didUpdateWidget(covariant AudioMessageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.audioUrl != oldWidget.audioUrl) {
      _initAudioPlayer(); // Re-initialize player if audioUrl changes
    }
  }

  Future<void> _initAudioPlayer() async {
    try {
      // Stop and reset player before loading new URL
      await _audioPlayer.stop();
      await _audioPlayer.seek(Duration.zero);

      await _audioPlayer.setUrl(widget.audioUrl);
      _duration = _audioPlayer.duration ?? Duration.zero;
      
      _audioPlayer.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
            // Reset position and icon when playback completes
            if (state.processingState == ProcessingState.completed) {
               _position = Duration.zero;
               _isPlaying = false; // Ensure isPlaying is false on completion
            }
          });
        }
      });

      _audioPlayer.positionStream.listen((position) {
        if (mounted) {
          setState(() {
            _position = position;
          });
        }
      });
       
    } catch (e) {
      debugPrint('Error initializing audio player: $e');
       if(mounted) {
         setState(() {
            _duration = Duration.zero; // Reset duration on error
            _position = Duration.zero;
            _isPlaying = false;
         });
       }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: widget.isMe ? kPrimaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                 if (_audioPlayer.playerState.processingState == ProcessingState.ready || _audioPlayer.playerState.processingState == ProcessingState.completed) { // Only toggle if ready or completed
                   if (_isPlaying) {
                     _audioPlayer.pause();
                   } else {
                      _audioPlayer.seek(Duration.zero); // Seek to start before playing again after completion
                     _audioPlayer.play();
                   }
                 }
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: widget.isMe ? Colors.white : Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Slider(
                    value: _position.inSeconds.toDouble(),
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    activeColor: widget.isMe ? Colors.white : kPrimaryColor,
                    inactiveColor: widget.isMe ? Colors.white70 : Colors.grey[400],
                    onChanged: (value) {
                      _audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                Text(
                  _formatDuration(_duration),
                  style: TextStyle(
                    color: widget.isMe ? Colors.white : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
             const SizedBox(width: 8),
             Text(
              widget.time,
              style: TextStyle(
                fontSize: 10,
                color: widget.isMe ? Colors.white70 : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 