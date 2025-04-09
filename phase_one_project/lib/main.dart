import 'package:flutter/material.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/path_routes.dart';
import 'presentation/widgets/bottom_nav_widget.dart';
import 'services/card_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CardStorageService().init();
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPathsRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: BottomNavWidget(),
    );
  }
}
