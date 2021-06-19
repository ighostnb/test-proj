import 'package:flutter/material.dart';
import 'package:test_proj/database/app_database.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _text = TextEditingController();
  bool _isShowTime = false;
  bool _isChangesSave = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildSaveButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  AppBar _buildAppBar() => AppBar(
        leading: GestureDetector(
          onTap: () {
            if (_isChangesSave) {
              Navigator.pop(context);
            } else {}
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Add note'),
        centerTitle: true,
      );

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
        child: Column(
          children: [
            _buildTitleField(),
            _buildTextField(),
            _buildCheckBox(),
          ],
        ),
      );

  Widget _buildTitleField() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        child: TextField(
          onChanged: (value) => _isShowTime = false,
          controller: _title,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
            prefixIcon: Icon(Icons.title),
          ),
        ),
      );

  Widget _buildTextField() => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: (value) => _isShowTime = false,
            controller: _text,
            maxLength: 255,
            maxLines: 8,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Text',
            ),
          ),
        ),
      );

  Widget _buildSaveButton(BuildContext context) => InkWell(
        onTap: () {
          AppDatabase().addTask(
            title: _title.text,
            text: _text.text,
            isShowTime: _isShowTime,
            time: DateTime.now().millisecondsSinceEpoch,
          );
          _isChangesSave = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Note saved successfully'),
            ),
          );
        },
        child: Container(
          color: Colors.blue,
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
          ),
        ),
      );

  Widget _buildCheckBox() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Show time'),
          Checkbox(
            value: _isShowTime,
            onChanged: (_) => setState(() => _isShowTime = !_isShowTime),
          ),
        ],
      );
}
