import 'package:flutter/material.dart';

import '../templates/base_template.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      titleAppar: 'Form screen',
      showLeadingBtnAppar: false,
      body: Center(
        child: Text('Hello Form screen!'),
      ),
    );
  }
}
