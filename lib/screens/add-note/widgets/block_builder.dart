import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_proj/models/task_model.dart';

class BlockBuilder extends StatelessWidget {
  final List<TaskModel> tasks;
  BlockBuilder({required this.tasks});
  @override
  Widget build(BuildContext context) => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        itemCount: tasks.length,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) => Container(
          color: Colors.teal.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(tasks[index].title),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(tasks[index].text),
              ),
              Text(tasks[index].isShowTime
                  ? DateTime.fromMillisecondsSinceEpoch(tasks[index].time)
                      .toString()
                      .substring(0, 19)
                  : ''),
            ],
          ),
        ),
      );
}
