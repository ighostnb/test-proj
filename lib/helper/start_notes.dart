import 'package:test_proj/database/app_database.dart';

class StartNotes {
  static addStartNotes() {
    AppDatabase().addNote(
        title: 'First note',
        text: 'This is first note',
        isShowTime: true,
        time: DateTime.now().millisecondsSinceEpoch,
        id: AppDatabase().getRandomId(15));

    AppDatabase().addNote(
        title: 'Second note',
        text: 'This is second note',
        isShowTime: true,
        time: DateTime.now().millisecondsSinceEpoch,
        id: AppDatabase().getRandomId(15));
  }
}
