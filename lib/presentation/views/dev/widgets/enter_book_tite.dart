import 'package:flutter/material.dart';

import '../dev_data_provider.dart';

class EnterBookTitle extends StatefulWidget {
  const EnterBookTitle({super.key});

  @override
  State<EnterBookTitle> createState() => _EnterBookTitleState();
}

class _EnterBookTitleState extends State<EnterBookTitle> {
  late final TextEditingController _bookTitleTextEditingController;

  @override
  void initState() {
    super.initState();
    _bookTitleTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _bookTitleTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Enter story book title"),
        TextField(
          controller: _bookTitleTextEditingController,
          onChanged: ((value) {
            DevDataProvider().bookTitleText = value;
          }),
        ),
      ],
    );
  }
}
