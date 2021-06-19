import 'package:flutter/material.dart';
import 'package:test_proj/database/app_database.dart';

import 'screens/note/task_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      );
}
