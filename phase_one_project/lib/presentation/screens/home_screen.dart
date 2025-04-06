import 'package:flutter/material.dart';

import '../templates/base_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      titleAppar: 'Home scren page',
      showLeadingBtnAppar: false,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/details');
          },
          child: const Text('Ir a AddScreen'),
        ),
      ),
    );
  }
}
