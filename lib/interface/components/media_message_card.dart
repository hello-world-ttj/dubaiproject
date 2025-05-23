import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dubaiprojectxyvin/interface/components/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_saver/file_saver.dart';

class MediaMessageCard extends StatefulWidget {
  final String mediaUrl;
  final String mediaType;
  final String time;
  final bool isMe;
  final String? fileName;
  final bool isLoading;

  const MediaMessageCard({
    Key? key,
    required this.mediaUrl,
    required this.mediaType,
    required this.time,
    required this.isMe,
    this.fileName,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<MediaMessageCard> createState() => _MediaMessageCardState();
}

class _MediaMessageCardState extends State<MediaMessageCard> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String? _fileSize;
  String? _videoDuration;
  final Dio _dio = Dio();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.mediaType == 'video') {
      _initializeVideo();
    }
    _getFileSize();
  }

  Future<void> _getFileSize() async {
    try {
      final response = await _dio.head(widget.mediaUrl);
      final size = response.headers.value('content-length');
      if (size != null) {
        final sizeInBytes = int.parse(size);
        setState(() {
          _fileSize = _formatFileSize(sizeInBytes);
        });
      }
    } catch (e) {
      debugPrint('Error getting file size: $e');
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.network(widget.mediaUrl);
    try {
      await _videoController!.initialize();
      _videoController!.addListener(_videoListener);
      setState(() {
        _isVideoInitialized = true;
        _videoDuration = _formatDuration(_videoController!.value.duration);
      });
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  void _videoListener() {
    if (_videoController!.value.position >= _videoController!.value.duration) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
        _isPlaying = false;
      } else {
        _videoController!.play();
        _isPlaying = true;
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  Future<void> _downloadMedia() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      // Download the file using Dio
      final response = await _dio.get(
        widget.mediaUrl,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      // Get file extension based on media type
      String extension;
      switch (widget.mediaType) {
        case 'image':
          extension = '.jpg';
          break;
        case 'video':
          extension = '.mp4';
          break;
        case 'document':
          extension = '.pdf';
          break;
        default:
          extension = '';
      }

      // Generate filename
      final fileName = widget.fileName ??
          '${widget.mediaType}_${DateTime.now().millisecondsSinceEpoch}$extension';

      // Save the file using file_saver
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: response.data,
        mimeType: MimeType.other,
        ext: extension.replaceAll('.', ''),
      );

      setState(() {
        _isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('${widget.mediaType.capitalize()} downloaded successfully'),
        ),
      );
    } catch (e) {
      debugPrint('Error downloading ${widget.mediaType}: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading ${widget.mediaType}')),
      );
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color:
              widget.isMe ? const Color(0xFFE6FFE2) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingAnimation(size: 30),
            const SizedBox(height: 8),
            Text(
              'Uploading ${widget.mediaType}...',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: widget.isMe ? const Color(0xFFE6FFE2) : const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.mediaType == 'image')
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        leading: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        actions: [
                          IconButton(
                            icon:
                                const Icon(Icons.download, color: Colors.white),
                            onPressed: _downloadMedia,
                          ),
                        ],
                      ),
                      body: Center(
                        child: InteractiveViewer(
                          child: Image.network(
                            widget.mediaUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.mediaUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (_fileSize != null)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _fileSize!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          else if (widget.mediaType == 'video')
            _isVideoInitialized
                ? GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Scaffold(
                      //       backgroundColor: Colors.black,
                      //       appBar: AppBar(
                      //         backgroundColor: Colors.black,
                      //         leading: IconButton(
                      //           icon: const Icon(Icons.close,
                      //               color: Colors.white),
                      //           onPressed: () => Navigator.pop(context),
                      //         ),
                      //         actions: [
                      //           IconButton(
                      //             icon: const Icon(Icons.download,
                      //                 color: Colors.white),
                      //             onPressed: _downloadMedia,
                      //           ),
                      //         ],
                      //       ),
                      //       body: Center(
                      //         child: AspectRatio(
                      //           aspectRatio:
                      //               _videoController!.value.aspectRatio,
                      //           child: Stack(
                      //             alignment: Alignment.center,
                      //             children: [
                      //               VideoPlayer(_videoController!),
                      //               GestureDetector(
                      //                 onTap: _togglePlayPause,
                      //                 child: Container(
                      //                   color: Colors.transparent,
                      //                   child: Center(
                      //                     child: Icon(
                      //                       _isPlaying
                      //                           ? Icons.pause
                      //                           : Icons.play_arrow,
                      //                       color: Colors.white,
                      //                       size: 50,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //               if (_videoDuration != null)
                      //                 Positioned(
                      //                   bottom: 16,
                      //                   right: 16,
                      //                   child: Container(
                      //                     padding: const EdgeInsets.symmetric(
                      //                         horizontal: 8, vertical: 4),
                      //                     decoration: BoxDecoration(
                      //                       color: Colors.black54,
                      //                       borderRadius:
                      //                           BorderRadius.circular(12),
                      //                     ),
                      //                     child: Text(
                      //                       _videoDuration!,
                      //                       style: const TextStyle(
                      //                         color: Colors.white,
                      //                         fontSize: 12,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(_videoController!),
                              GestureDetector(
                                onTap: _togglePlayPause,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Icon(
                                      _isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_videoDuration != null)
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _videoDuration!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon:
                                const Icon(Icons.download, color: Colors.white),
                            onPressed: _downloadMedia,
                          ),
                        ),
                      ],
                    ),
                  )  
                :  Center(child:    Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 100,
      width: double.infinity,
      color: Colors.grey[300],
    ),
  ))
          else if (widget.mediaType == 'document')
            GestureDetector(
              onTap: _isDownloading ? null : _downloadMedia,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.insert_drive_file, size: 40),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.fileName ?? 'Document',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (_fileSize != null)
                                Text(
                                  _fileSize!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (_isDownloading)
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              value: _downloadProgress,
                              strokeWidth: 2,
                            ),
                          )
                        else
                          const Icon(Icons.download),
                      ],
                    ),
                    if (_isDownloading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: LinearProgressIndicator(
                          value: _downloadProgress,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 5),
          Text(
            widget.time,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
