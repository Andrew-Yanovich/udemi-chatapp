import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  const UserImagePicker({Key? key, required this.imagePickFn}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final rawPickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );
      setState(() {
        _pickedImage = rawPickedImage != null ? File(rawPickedImage.path) : null;
      });
      if (_pickedImage != null) {
        widget.imagePickFn(_pickedImage!);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
            overlayColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor.withOpacity(0.04)),
          ),
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
