import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String text;

  @HiveField(2)
  late int time;

  @HiveField(3)
  late bool isShowTime;
}
