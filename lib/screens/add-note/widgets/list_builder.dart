import 'package:flutter/material.dart';
import 'package:test_proj/models/task_model.dart';

class ListBuilder extends StatelessWidget {
  final List<TaskModel> tasks;
  ListBuilder({required this.tasks});
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => SizedBox(
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
      );
}
