import 'package:flutter/material.dart';

import '../templates/base_template.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      titleAppar: ' Detail screen',
      showLeadingBtnAppar: false,
      body: Center(
        child: Text('Hello Detail screen!'),
      ),
    );
  }
}
