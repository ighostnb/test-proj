import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  Future initDatabase() async {
    Directory? dir = await getExternalStorageDirectory();
    Hive.init(dir!.path);
  }
}
