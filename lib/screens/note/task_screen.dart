import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_proj/database/boxes.dart';
import 'package:test_proj/models/task_model.dart';
import 'package:test_proj/screens/add-note/add_note_screen.dart';
import 'package:test_proj/screens/add-note/widgets/block_builder.dart';
import 'package:test_proj/screens/add-note/widgets/list_builder.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _listView = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      );

  Widget _buildBody() => ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Boxes.getTask().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<TaskModel>();
          return _listView
              ? Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: ListBuilder(tasks: tasks),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: BlockBuilder(tasks: tasks),
                );
        },
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text('Notes'),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.add,
                size: 35,
              ),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNoteScreen())),
          ),
        ],
        leading: GestureDetector(
          onTap: () => setState(() => _listView = !_listView),
          child: Icon(
            Icons.app_registration_sharp,
            size: 35,
          ),
        ),
      );
}
