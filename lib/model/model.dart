class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> dummyTodoList() {
    return [
      ToDo(id: "0", todoText: "Dummy Item", isDone: true),
      ToDo(id: "1", todoText: "Dummy Item", isDone: true),
      ToDo(id: "2", todoText: "Dummy Item"),
      ToDo(id: "3", todoText: "Dummy Item"),
    ];
  }
}