import 'package:flutter/material.dart';
import 'package:todoapp/model/model.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.dummyTodoList();
  List<ToDo> _todoCurrently = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _todoCurrently = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBody(),
          _buildAddToDo(),
        ],
      ),
    );
  }

  void _handleChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _handleTodoEntry(String toDoItem) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDoItem));
      _todoController.clear();
    });
  }

  void _runSearch(String keyword) {
    List<ToDo> results = [];
    if (keyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _todoCurrently = results;
    });
  }

  Container _buildBody() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [_buildSearchBar(), Expanded(child: _buildToDoList())],
        ));
  }

  Align _buildAddToDo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0)
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                    hintText: 'What we getting done today?!',
                    border: InputBorder.none)),
          )),
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              child: Text(
                '+',
                style: TextStyle(fontSize: 40),
              ),
              onPressed: () {
                _handleTodoEntry(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                primary: tdBlue,
                minimumSize: Size(50, 50),
                elevation: 10,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildToDoList() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 50,
            bottom: 20,
          ),
          child: Text(
            'All ToDos',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        for (ToDo item in _todoCurrently.reversed)
          TodoItem(
            toDo: item,
            onTodoChanged: _handleChange,
            onTodoDeleted: _handleDelete,
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runSearch(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBgColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 45,
          width: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/profile.png'),
          ),
        )
      ]),
    );
  }
}
