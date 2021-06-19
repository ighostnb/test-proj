import 'package:hive/hive.dart';
import 'package:test_proj/models/task_model.dart';

class Boxes {
  static Box<TaskModel> getTask() => Hive.box<TaskModel>('task');
}
