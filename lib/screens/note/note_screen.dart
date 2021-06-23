import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_proj/database/boxes.dart';
import 'package:test_proj/models/task_model.dart';
import 'package:test_proj/screens/add-note/add_note_screen.dart';
import 'package:test_proj/screens/add-note/widgets/block_builder.dart';
import 'package:test_proj/screens/add-note/widgets/list_builder.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _visibleList = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _buildAddButton(),
      );

  Widget _buildBody() => ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Boxes.getTask().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<TaskModel>();
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Stack(
              children: [
                AbsorbPointer(
                  absorbing: _visibleList ? true : false,
                  child: AnimatedOpacity(
                    opacity: _visibleList ? 0 : 1,
                    duration: Duration(seconds: 1),
                    child: BlockBuilder(tasks: tasks),
                  ),
                ),
                AbsorbPointer(
                  absorbing: _visibleList ? false : true,
                  child: AnimatedOpacity(
                    child: ListBuilder(tasks: tasks),
                    duration: Duration(seconds: 1),
                    opacity: _visibleList ? 1 : 0,
                  ),
                ),
              ],
            ),
          );
        },
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text('Notes'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => setState(() => _visibleList = !_visibleList),
          child: Icon(
            Icons.app_registration_sharp,
            size: 35,
          ),
        ),
      );

  Widget _buildAddButton() => ElevatedButton(
        child: Icon(Icons.add),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(60, 60),
        ),
        onPressed: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return AddNoteScreen(animation);
            },
            transitionDuration: Duration(milliseconds: 400),
          ),
        ),
      );
}
