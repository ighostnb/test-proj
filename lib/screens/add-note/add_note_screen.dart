import 'package:flutter/material.dart';
import 'package:test_proj/database/app_database.dart';

class AddNoteScreen extends StatefulWidget {
  final transitionAnimation;
  AddNoteScreen(this.transitionAnimation);
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen>
    with TickerProviderStateMixin {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _text = TextEditingController();

  bool _isShowTime = false;
  bool _isChangesSave = true;
  final FocusNode _focusTitle = FocusNode();
  final FocusNode _focusText = FocusNode();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      value: 0.1,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.transitionAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset(0, 0),
            ).animate(widget.transitionAnimation),
            child: child,
          );
        },
        child: WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
          ),
        ),
      );

  AppBar _buildAppBar() => AppBar();

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
          focusNode: _focusTitle,
          onChanged: (value) {
            _isChangesSave = false;
            _showSaveButton();
          },
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
            focusNode: _focusText,
            onChanged: (value) {
              _isChangesSave = false;
              _showSaveButton();
            },
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

  void _showSaveButton() {
    _hideSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: InkWell(
          onTap: _saveNote,
          child: Container(
            height: 50,
            child: Center(
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBox() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Show time'),
          Checkbox(
            value: _isShowTime,
            onChanged: (_) {
              setState(() => _isShowTime = !_isShowTime);
              _isChangesSave = false;
              _showSaveButton();
            },
          ),
        ],
      );

  Future<bool> _onWillPop(context) async {
    if (_isChangesSave) {
      return true;
    }
    _controller.reset();
    _controller.forward();

    return await showDialog(
          context: context,
          builder: (context) {
            _hideSnackBars();

            return ScaleTransition(
              scale: _animation,
              child: AlertDialog(
                title: Text('Do you want to save your changes?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      _saveNote();
                      Navigator.pop(context, true);
                    },
                    child: Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('No'),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }

  void _hideSnackBars() => ScaffoldMessenger.of(context).clearSnackBars();

  void _saveNote() {
    AppDatabase().addNote(
      title: _title.text,
      text: _text.text,
      isShowTime: _isShowTime,
      time: DateTime.now().millisecondsSinceEpoch,
    );
    _isChangesSave = true;

    _focusTitle.unfocus();
    _focusText.unfocus();
    _hideSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Note saved successfully'),
      ),
    );
  }
}
