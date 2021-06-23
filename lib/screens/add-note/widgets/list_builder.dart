import 'package:flutter/material.dart';
import 'package:test_proj/database/app_database.dart';
import 'package:test_proj/database/boxes.dart';
import 'package:test_proj/screens/add-note/add_note_screen.dart';

class ListBuilder extends StatelessWidget {
  final tasks;
  final box = Boxes.getTask();
  ListBuilder({required this.tasks});
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return AddNoteScreen(animation, [
                  tasks[index].title,
                  tasks[index].text,
                  tasks[index].isShowTime,
                  tasks[index].time,
                  tasks[index].id,
                ]);
              },
              transitionDuration: Duration(milliseconds: 400),
            ),
          ),
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              final note = [
                tasks[index].title,
                tasks[index].text,
                tasks[index].isShowTime,
                tasks[index].time,
                tasks[index].id,
              ];
              AppDatabase().removeNote(tasks[index].id);
              final SnackBar snackBar = SnackBar(
                duration: Duration(seconds: 5),
                content: Text('Cancel the current action'),
                action: SnackBarAction(
                  label: 'Cancel',
                  onPressed: () {
                    AppDatabase().addNote(
                      id: note[4],
                      title: note[0],
                      text: note[1],
                      isShowTime: note[2],
                      time: note[3],
                    );
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            background: Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 3,
            ),
            child: SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(tasks[index].title),
                    ),
                    if (tasks[index].isShowTime)
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          DateTime.fromMillisecondsSinceEpoch(tasks[index].time)
                              .toString()
                              .substring(0, 19),
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
