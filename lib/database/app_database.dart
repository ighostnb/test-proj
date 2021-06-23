import 'package:hive/hive.dart';
import 'package:test_proj/database/boxes.dart';
import 'package:test_proj/models/task_model.dart';

class AppDatabase {
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
  }) {
    final _task = TaskModel()
      ..isShowTime = isShowTime
      ..text = text
      ..title = title
      ..time = time;
    final box = Boxes.getTask();
    box.put('$time', _task);
  }

  void removeNote(int time) {
    final box = Boxes.getTask();
    box.delete('$time');
  }
}
