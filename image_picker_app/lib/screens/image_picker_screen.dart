import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  // 1. Separate storage variables based on the platform
  File? _mobileImage; // Stored as dart:io File for Android/iOS/Desktop
  XFile? _webImage; // Stored as XFile ONLY for Web

  final ImagePicker _picker = ImagePicker();

  // Function to pick image
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          // 2. Condition to store as XFile if Web, else as File
          if (kIsWeb) {
            _webImage = pickedFile;
          } else {
            _mobileImage = File(pickedFile.path);
          }
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("No image selected")));
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // 3. Function to clear/remove the selected image
  void _removeImage() {
    setState(() {
      _webImage = null;
      _mobileImage = null;
    });
  }

  // Helper method to check if an image is selected
  bool get _hasImage => _webImage != null || _mobileImage != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery Image Picker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display Image with a Cross Sign or fallback text
            _hasImage
                ? Stack(
                    children: [
                      // The Image Container
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: kIsWeb
                              ? Image.network(
                                  _webImage!.path, // Display XFile for web
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _mobileImage!, // Display File for mobile
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),

                      // 4. The Cross Sign (Remove Button)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: _removeImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color:
                                  Colors.black54, // Semi-transparent background
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Text(
                    "No image selected",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),

            const SizedBox(height: 30),

            // Pick Image Button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text("Select Image"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
