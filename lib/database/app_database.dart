import 'package:hive/hive.dart';
import 'package:test_proj/database/boxes.dart';
import 'package:test_proj/models/task_model.dart';
import 'dart:math';

class AppDatabase {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String getRandomId(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future initDatabase() async {
    // Directory? dir = await getExternalStorageDirectory();
    // Hive.init(dir!.path);

    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>('task');
  }

  void addNote({
    required String title,
    required String text,
    required bool isShowTime,
    required int time,
    required String id,
  }) {
    final _task = TaskModel()
      ..isShowTime = isShowTime
      ..text = text
      ..title = title
      ..time = time
      ..id = id;
    final box = Boxes.getTask();
    box.put('$id', _task);
  }

  void removeNote(String id) {
    final box = Boxes.getTask();
    box.delete('$id');
  }
}
