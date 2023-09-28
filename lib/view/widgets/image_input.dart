import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'dart:io';
import 'dart:async';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, this.saveImage});
  final Function? saveImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final _imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(_imageFile.path);
    });

    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_imageFile.path);
    final _pickedImage =
        await _storedImage!.copy("${appDir.path}/  ${fileName}");

    widget.saveImage!(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 150,
          width: 150,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                )
              : const Text("No image taken"),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: takePicture,
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary),
              icon: const Icon(Icons.camera),
              label: const Text("Take Picture")),
        )
      ],
    );
  }
}
