import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePic() async {
    final imagepicker = ImagePicker();
    final pickedImage =
        await imagepicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget conetnt = TextButton.icon(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onBackground),
            textStyle: MaterialStatePropertyAll(TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ))),
        onPressed: _takePic,
        icon: const Icon(
          Icons.camera,
          size: 25,
        ),
        label: const Text('Take a picture'));

    if (_selectedImage != null) {
      conetnt = GestureDetector(
        onTap: _takePic,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
            border: Border.all(
          width: 2.5,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        )),
        child: conetnt);
  }
}
