import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/todo_database.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var todoDatabase =TodoDatabase();

  //final _myBox =Hive.box('todoBox') ;
  List<TodoModel> todoList =[];

  @override
  void initState() {

      todoList= todoDatabase.getTodos();
  }

  final _controller = TextEditingController();

  void oncheckedBoxChanged(bool? value, int index){
    setState(() {
  todoList[index].isCompleted = !todoList[index].isCompleted;
  todoDatabase.updateTodo(index, todoList[index]);
    });
  }


  void onCancelDialod(){
    _controller.clear();
    Navigator.pop(context);
  }


  void onSaveTask(){
   setState(() {
     var newTask=TodoModel(taskName: _controller.text, isCompleted: false);
    todoList.add(newTask);
    todoDatabase.addTodo(newTask);
   });
   _controller.clear();
   Navigator.pop(context);
  }

  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onCancel: onCancelDialod,
        onSave: onSaveTask,

      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('ToDo App',style: TextStyle(color: Colors.white),),
     actions: [
       IconButton(onPressed: (){Navigator.pushNamed(context, '/settingsPage');}, icon: Container(
         decoration: BoxDecoration(
           color: Colors.white.withOpacity(0.1),
           borderRadius: BorderRadius.circular(12)
         ),
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Icon(Icons.settings),
         ),
         
         
       ))
     ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,

      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context,index){
            return Dismissible(
              key: Key( todoList[index].taskName),
              direction: DismissDirection.endToStart,
              onDismissed: (direction){
                setState(() {
                  todoList.removeAt(index);
                  todoDatabase.deleteTodo(index);
                });
              },
              child: TodoTile(
                  taskName: todoList[index].taskName,
                  isCompleted: todoList[index].isCompleted,
                  onChanged:(value) => oncheckedBoxChanged(value, index)),
            );

      })
    );
  }
}
