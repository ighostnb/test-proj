import 'package:flutter/material.dart';
import 'package:test_proj/database/app_database.dart';
import 'package:test_proj/database/boxes.dart';

class ListBuilder extends StatelessWidget {
  final tasks;
  final box = Boxes.getTask();
  ListBuilder({required this.tasks});
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            final note = [
              tasks[index].title,
              tasks[index].text,
              tasks[index].isShowTime,
              tasks[index].time
            ];
            AppDatabase().removeNote(tasks[index].time);
            final SnackBar snackBar = SnackBar(
              duration: Duration(seconds: 5),
              content: Text('Cancel the current action'),
              action: SnackBarAction(
                label: 'Cancel',
                onPressed: () {
                  AppDatabase().addNote(
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
      );
}
