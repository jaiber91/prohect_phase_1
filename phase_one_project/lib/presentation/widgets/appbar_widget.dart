import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackBtn;
  final bool centerTitle;
  const AppbarWidget({
    super.key,
    required this.title,
    required this.centerTitle,
    this.showBackBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackBtn ? BackButton() : null,
      title: Text(title),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
