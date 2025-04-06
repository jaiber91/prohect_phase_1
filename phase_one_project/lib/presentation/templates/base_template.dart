import 'package:flutter/material.dart';

import '../widgets/appbar_widget.dart';

class BaseTemplate extends StatelessWidget {
  final String titleAppar;
  final bool? showLeadingBtnAppar;
  final bool? centerTitleAppar;
  final Widget body;
  const BaseTemplate({
    super.key,
    required this.titleAppar,
    this.showLeadingBtnAppar,
    this.centerTitleAppar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: titleAppar,
        showBackBtn: showLeadingBtnAppar ?? true,
        centerTitle: centerTitleAppar ?? true,
      ),
      body: SafeArea(child: body),
    );
  }
}
