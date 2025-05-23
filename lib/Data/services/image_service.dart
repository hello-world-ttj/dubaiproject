import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dubaiprojectxyvin/Data/utils/globals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:video_compress/video_compress.dart';
import 'package:file_picker/file_picker.dart';

class MediaService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String> mediaUpload(String mediaUpload) async {
    File imageFile = File(mediaUpload);
    Uint8List imageBytes = await imageFile.readAsBytes();
    print("Original image size: ${imageBytes.lengthInBytes / 1024} KB");

    // Check if the image is larger than 1 MB
    if (imageBytes.lengthInBytes > 1024 * 1024) {
      img.Image? image = img.decodeImage(imageBytes);
      if (image != null) {
        img.Image resizedImage =
            img.copyResize(image, width: (image.width * 0.5).toInt());
        imageBytes =
            Uint8List.fromList(img.encodeJpg(resizedImage, quality: 80));
        print("Compressed image size: ${imageBytes.lengthInBytes / 1024} KB");

        // Save compressed image
        imageFile = await File(mediaUpload).writeAsBytes(imageBytes);
      }
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload'),
    );
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      MediaService imageService = MediaService();
      return imageService.extractMediaUrl(responseBody);
    } else {
      var responseBody = await response.stream.bytesToString();
      log(responseBody.toString());
      throw Exception('Failed to upload image');
    }
  }

  static Future<String> audioUpload(String audioPath) async {
    File audioFile = File(audioPath);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload'),
    );

    request.files
        .add(await http.MultipartFile.fromPath('image', audioFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      MediaService mediaService = MediaService();
      return mediaService.extractMediaUrl(responseBody);
    } else {
      var responseBody = await response.stream.bytesToString();
      log(responseBody.toString());
      throw Exception('Failed to upload audio');
    }
  }

  static Future<String> videoUpload(String videoPath) async {
    try {
      File videoFile = File(videoPath);
      int originalSize = await videoFile.length();
      print("Original video size: ${originalSize / (1024 * 1024)} MB");

      if (originalSize > 10 * 1024 * 1024) {
        final MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          videoPath,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
        );

        if (mediaInfo?.file != null) {
          videoFile = mediaInfo!.file!;
          print(
              "Compressed video size: ${mediaInfo.filesize! / (1024 * 1024)} MB");
        }
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload'),
      );

      request.files
          .add(await http.MultipartFile.fromPath('image', videoFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        MediaService mediaService = MediaService();
        return mediaService.extractMediaUrl(responseBody);
      } else {
        var responseBody = await response.stream.bytesToString();
        log(responseBody.toString());
        throw Exception('Failed to upload video');
      }
    } catch (e) {
      log('Error uploading video: $e');
      throw Exception('Failed to upload video: $e');
    } finally {
      // Clean up compressed video if it exists
      await VideoCompress.deleteAllCache();
    }
  }

  static Future<String> documentUpload(String documentPath) async {
    try {
      File documentFile = File(documentPath);
      
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload'),
      );
      
      request.files
          .add(await http.MultipartFile.fromPath('image', documentFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        MediaService mediaService = MediaService();
        return mediaService.extractMediaUrl(responseBody);
      } else {
        var responseBody = await response.stream.bytesToString();
        log(responseBody.toString());
        throw Exception('Failed to upload document');
      }
    } catch (e) {
      log('Error uploading document: $e');
      throw Exception('Failed to upload document: $e');
    }
  }

  static Future<File?> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt'],
      );

      if (result != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      log('Error picking document: $e');
      return null;
    }
  }

  String extractMediaUrl(String responseBody) {
    final responseJson = jsonDecode(responseBody);
    log(name: "media upload response", responseJson.toString());
    return responseJson['data'];
  }

  static Future<File?> pickAndCropImage({
    required BuildContext context,
    required CustomImageCropController cropController,
    ImageSource source = ImageSource.gallery,
    Ratio? ratio,
    CustomCropShape shape = CustomCropShape.Circle,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image == null) return null;

      final File imageFile = File(image.path);

      // Show cropping dialog
      final File? croppedFile = await showDialog<File>(
        context: context,
        builder: (context) => _ImageCropDialog(
          imageFile: imageFile,
          cropController: cropController,
          ratio: ratio,
          shape: shape,
        ),
      );

      return croppedFile;
    } catch (e) {
      debugPrint('Error picking/cropping image: $e');
      return null;
    }
  }
}

class _ImageCropDialog extends StatefulWidget {
  final File imageFile;
  final CustomImageCropController cropController;
  final Ratio? ratio;
  final CustomCropShape shape;

  const _ImageCropDialog({
    required this.imageFile,
    required this.cropController,
    this.ratio,
    required this.shape,
  });

  @override
  State<_ImageCropDialog> createState() => _ImageCropDialogState();
}

class _ImageCropDialogState extends State<_ImageCropDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 400,
            child: CustomImageCrop(
              cropController: widget.cropController,
              image: FileImage(widget.imageFile),
              ratio: widget.ratio,
              shape: widget.shape,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final croppedImage =
                      await widget.cropController.onCropImage();
                  if (croppedImage != null) {
                    // Convert MemoryImage to File
                    final tempDir = await getTemporaryDirectory();
                    final file = File('${tempDir.path}/cropped_image.jpg');
                    await file.writeAsBytes(croppedImage.bytes);
                    Navigator.pop(context, file);
                  }
                },
                child: const Text('Crop'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
