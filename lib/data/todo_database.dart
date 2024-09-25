import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/models/todo_model.dart';

class TodoDatabase{


  final _myBox = Hive.box<TodoModel>('todoBox');

  void addTodo(TodoModel todoModel){
    _myBox.add(todoModel);
  }

  List<TodoModel>getTodos(){
    return _myBox.values.toList();
  }

  void deleteTodo(int index){
    _myBox.deleteAt(index);
  }

  void updateTodo(int index, TodoModel todoModel){
    _myBox.putAt(index, todoModel);
  }

}