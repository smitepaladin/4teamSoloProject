import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/important_model.dart';
import 'package:my_to_do_list/model/recycle_model.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/addtodolist.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';
import 'package:my_to_do_list/view/menudrawer.dart';
import 'package:my_to_do_list/model/messege.dart';

class TodoListMain extends StatefulWidget {
  const TodoListMain({super.key});

  @override
  State<TodoListMain> createState() => _TodoListMainState();
}

class _TodoListMainState extends State<TodoListMain> {
  //Property
  late List<TodoListModel> todoListModel;
  late List<ImportantModel> importantModel;
  late List<RecycleModel> recyclemodel;

  @override
  void initState() {
    super.initState();
    todoListModel = [];
    importantModel = [];
    recyclemodel = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await Get.to(Addtodolist());
              rebuildData();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Addtodolist()),
              // ).then((value) => rebuildData());
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      drawer: Menudrawer(),
      body: Center(
        child: ListView.builder(
          itemCount: todoListModel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              // 카드는 터치기능이 없다. 그래서 제스쳐디텍터를 넣어줘야한다.
              onTap: () {
                // Message.imagePath = todoListModel[index].imagePath;
                // Message.workList =
                //     todoListModel[index]
                //         .workList; // message.dart에서 선언한 Static Class
                // Message.date = todoListModel[index].date;
                // Message.category = todoListModel[index].category;
                // await Get.to(DetailTodoList());

                Message.imagePath = todoListModel[index].imagePath;
                Message.workList =
                    todoListModel[index]
                        .workList; // message.dart에서 선언한 Static Class
                Message.date = todoListModel[index].date;
                Message.category = todoListModel[index].category;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailTodoList()),
                ).then((value) => getData());
              },
              child: SizedBox(
                height: 100,
                child: Card(
                  color:
                      todoListModel[index].check
                          ? Colors.amberAccent
                          : Colors.white,
                  child: Row(
                    children: [
                      Checkbox(
                        value: todoListModel[index].check,
                        onChanged: (value) {
                          todoListModel[index].check = value!;
                          setState(() {});
                        },
                      ),
                      Image.asset(todoListModel[index].imagePath, height: 50),
                      SizedBox(
                        height: 80,
                        width: 230,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(todoListModel[index].category),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(todoListModel[index].workList),
                                ),
                              ],
                            ),
                            Text(
                              todoListModel[index].date.toString().substring(
                                0,
                                10,
                              ),
                            ),
                          ],
                        ),
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
  } //build

  // functions ///

  rebuildData() {
    if (Message.action == true) {
      todoListModel.add(
        TodoListModel(
          imagePath: Message.imagePath,
          workList: Message.workList,
          category: Message.category,
          check: Message.check,
          star: Message.star,
          date: Message.date,
        ),
      );

      Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
      setState(() {});
    }
  }

getData() {
  if (Message.action == true) {
  TodoListModel(
        imagePath: Message.imagePath,
        workList: Message.workList,
        category: Message.category,
        check: false,  // 기본값을 false로 설정 (수정 시 체크박스 상태)
        star: false,   // 기본값을 false로 설정
        date: Message.date,
      );
    } 

    Message.action = false; // 데이터를 추가했으므로 action을 false로 설정
    setState(() {});  // 화면 갱신
  }

}//Class