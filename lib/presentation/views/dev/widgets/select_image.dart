
import 'dart:io';

import 'package:flutter/material.dart';

import '../dev_data_provider.dart';
import '../image_picker.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key, this.isVocabImage = false});
  final bool isVocabImage;
  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  String? _imagePath;
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () async {
            _imagePath = await pickImage();
            setState(() {
              widget.isVocabImage ? DevDataProvider().vocabImagePath = _imagePath : DevDataProvider().imagePath = _imagePath;
            });
          },
          child: const Text("Select study page image"),
        ),
        Visibility(
          visible: _imagePath != null,
          child: _imagePath != null
              ? Image.file(
                  File(_imagePath!),
                )
              : Container(),
        ),
      ],
    );
  }
}
