import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_proj/screens/add-note/add_note_screen.dart';

class BlockBuilder extends StatelessWidget {
  final Random r = Random();
  final tasks;
  BlockBuilder({required this.tasks});
  @override
  Widget build(BuildContext context) => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        itemCount: tasks.length,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) => _buildItem(index, context),
      );

  Widget _buildItem(index, context) => InkWell(
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
        child: Container(
          decoration: BoxDecoration(
            color: _getCardColor(),
            borderRadius: BorderRadius.circular(8),
          ),
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

  Color _getCardColor() => Color.fromARGB(
        r.nextInt(255),
        r.nextInt(255),
        r.nextInt(255),
        r.nextInt(255),
      );
}
