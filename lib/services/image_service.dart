import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

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
