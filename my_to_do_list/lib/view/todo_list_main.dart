import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/addtodolist.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';

class TodoListMain extends StatefulWidget {
  const TodoListMain({super.key});

  @override
  State<TodoListMain> createState() => _TodoListMainState();
}

class _TodoListMainState extends State<TodoListMain> {
  //Property
  late List<TodoListModel> todoListModel;


  @override
  void initState() {
    super.initState();
    todoListModel = [];
    addData();
  }

    addData(){
    todoListModel.add(TodoListModel(imagePath: 'images/cart.png', workList: '책구매', date: DateTime.now()));
    todoListModel.add(TodoListModel(imagePath: 'images/clock.png', workList: '약속', date: DateTime.now()));
    todoListModel.add(TodoListModel(imagePath: 'images/pencil.png', workList: '스터디', date: DateTime.now()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [ // 앱바 버튼은 actions 로 만든다
          IconButton(
            onPressed: () async{
              await Get.to(Addtodolist());
              rebuildData();
            },
            icon: Icon(Icons.add_outlined)
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todoListModel.length,
          itemBuilder: (context, index) {
            return GestureDetector( // 카드는 터치기능이 없다. 그래서 제스쳐디텍터를 넣어줘야한다.
              onTap: () async{
                Message.imagePath = todoListModel[index].imagePath;
                Message.workList = todoListModel[index].workList; // message.dart에서 선언한 Static Class
                await Get.to(DetailTodoList());
                rebuildData();
              },
              child: SizedBox(
                height: 60,
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          todoListModel[index].imagePath,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                        child: Text(
                          todoListModel[index].workList,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                        child: Text(
                          todoListModel[index].date.toString()
                        )
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }//build

  // == Functions ==

  rebuildData(){
    if(Message.action == true){
      todoListModel.add(TodoListModel(imagePath: Message.imagePath, workList: Message.workList, date: Message.date));
      Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
    }
    
    setState(() {});
  }
}//Class