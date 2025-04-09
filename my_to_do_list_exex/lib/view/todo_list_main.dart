import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/recycle_model.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/model/important_model.dart';
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

  @override
  void initState() {
    super.initState();
    todoListModel = Message.todoListModel;
    setState(() {});
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
        child:
            todoListModel.isEmpty
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      '일정이 비었습니다.',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '상단 추가 버튼을 눌러서 일정을 추가하세요.',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                )
                : ListView.builder(
                  itemCount: todoListModel.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // 중요일정인 경우 스와이프를 못하도록 설정
                      direction:
                          todoListModel[index].star
                              ? DismissDirection
                                  .none // 중요 일정인 경우에는 스와이프 불가
                              : DismissDirection.endToStart, // 일반 일정은 스와이프 가능
                      key: ValueKey(todoListModel[index]),
                      onDismissed: (direction) {
                        Message.recycleListModel.add(
                          RecycleModel(
                            imagePath: todoListModel[index].imagePath,
                            workList: todoListModel[index].workList,
                            category: todoListModel[index].category,
                            check: todoListModel[index].check,
                            star: todoListModel[index].star,
                            date: todoListModel[index].date,
                          ),
                        );

                        todoListModel.removeAt(index);
                        setState(() {});
                        snackbar();
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.delete_forever, size: 50),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          Message.imagePath = todoListModel[index].imagePath;
                          Message.workList = todoListModel[index].workList;
                          Message.date = todoListModel[index].date;
                          Message.category = todoListModel[index].category;
                          Message.index = index;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTodoList(),
                            ),
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
                                Image.asset(
                                  todoListModel[index].imagePath,
                                  height: 50,
                                ),
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
                                            child: Text(
                                              todoListModel[index].category,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              todoListModel[index].workList,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        todoListModel[index].date
                                            .toString()
                                            .substring(0, 10),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    todoListModel[index].star =
                                        !todoListModel[index].star;

                                    if (todoListModel[index].star == true) {
                                      importantAddSnack();

                                      Message.importantListModel.add(
                                        ImportantModel(
                                          imagePath:
                                              todoListModel[index].imagePath,
                                          workList:
                                              todoListModel[index].workList,
                                          category:
                                              todoListModel[index].category,
                                          check: todoListModel[index].check,
                                          star: true,
                                          date: todoListModel[index].date,
                                        ),
                                      );
                                    } else {
                                      importantDelSnack();

                                      Message.importantListModel.removeWhere(
                                        (item) =>
                                            item.imagePath ==
                                                todoListModel[index]
                                                    .imagePath &&
                                            item.workList ==
                                                todoListModel[index].workList &&
                                            item.date ==
                                                todoListModel[index].date,
                                      );
                                    }

                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color:
                                        todoListModel[index].star
                                            ? Colors.yellow
                                            : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
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
      Message.todoListModel.add(
        TodoListModel(
          imagePath: Message.imagePath,
          workList: Message.workList,
          category: Message.category,
          check: Message.check,
          star: Message.star,
          date: Message.date,
        ),
      );

      Message.action = false;
      setState(() {});
    }
  }

  getData() {
    if (Message.action == true &&
        Message.index != -1 &&
        Message.index < Message.todoListModel.length) {
      Message.todoListModel[Message.index] = TodoListModel(
        imagePath: Message.imagePath,
        workList: Message.workList,
        category: Message.category,
        check: Message.todoListModel[Message.index].check,
        star: Message.todoListModel[Message.index].star,
        date: Message.date,
      );

      Message.action = false;
      Message.index = -1;
      setState(() {});
    }
  }


  snackbar(){
    Get.snackbar(
      '일정이 삭제되었습니다.', // 변수도 넣을 수 있다
      '휴지통에서 복원이 가능합니다.',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  importantAddSnack() {
    Get.snackbar(
      '중요일정이 추가되었습니다.', // 변수도 넣을 수 있다
      '중요일정은 삭제가 불가능합니다.',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  importantDelSnack() {
    Get.snackbar(
      '중요일정이 해제되었습니다.', // 변수도 넣을 수 있다
      '중요일정 목록에서도 삭제되었습니다.',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}//Class