import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../screens/form_screen.dart';
import 'path_routes.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppPathsRoutes.details: (context) => const DetailScreen(),
    AppPathsRoutes.form: (context) => const FormScreen(),
  };
}
