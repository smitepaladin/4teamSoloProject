import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/controller/todoListController.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/addtodolist.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';
import 'package:my_to_do_list/view/menudrawer.dart';
import 'package:my_to_do_list/view/recycle_bin.dart';

class TodoListMain extends StatefulWidget {
  const TodoListMain({super.key});

  @override
  State<TodoListMain> createState() => _TodoListMainState();
}

class _TodoListMainState extends State<TodoListMain> {
  final TodoListController controller = Get.put(TodoListController());
  var value = Get.arguments;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.addPostFrameCallback 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addData();
    });
  }

  addData() {
    if (value != null) {
      controller.addTodo(
        TodoListModel(
          imagePath: value.recycleimagePath,
          workList: value.recycleworkList,
          date: value.recycledate,
          category: value.recyclecategory,
          check: value.recyclecheck,
          star: value.recyclestar,
        ),
      );
    }
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
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      drawer: Menudrawer(),
      body: Center(
        child: Obx(() {
          // Obx를 사용하여 controller의 todoListModel이 변경될 때마다 UI가 업데이트되도록 함
          if (controller.todoListModel.isEmpty) {
            return Center(
              child: Text(
                '일정이 비었습니다.\n\n상단 추가버튼을 눌러서 일정을 추가하세요.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.todoListModel.length,
            itemBuilder: (context, index) {
              return Dismissible(
                // 중요일정인 경우 스와이프를 못하도록 설정
                direction:
                    controller.todoListModel[index].star
                        ? DismissDirection
                            .none // 중요 일정인 경우에는 스와이프 불가
                        : DismissDirection.endToStart, // 일반 일정은 스와이프 가능
                key: ValueKey(controller.todoListModel[index]),
                onDismissed: (direction) {
                  Get.to(
                    RecycleBin(),
                    arguments: controller.todoListModel[index],
                  );
                  controller.removeTodo(controller.todoListModel[index]);
                  buttonSnack();
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.delete_forever, size: 50),
                ),
                child: GestureDetector(
                  onTap: () async {
                    Message.imagePath =
                        controller.todoListModel[index].imagePath;
                    Message.workList = controller.todoListModel[index].workList;
                    Message.date = controller.todoListModel[index].date;
                    Message.category = controller.todoListModel[index].category;
                    await Get.to(DetailTodoList());
                  
                  },
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      color:
                          controller.todoListModel[index].check
                              ? Colors.amberAccent
                              : Colors.white,
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.todoListModel[index].check,
                            onChanged: (value) {
                              controller.todoListModel[index].check = value!;
                              setState(() {});
                            },
                          ),
                          Image.asset(
                            controller.todoListModel[index].imagePath,
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
                                        controller.todoListModel[index].category,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        controller.todoListModel[index].workList,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                              controller.todoListModel[index].date
                                  .toString()
                                  .substring(0, 10),
                            ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.todoListModel[index].star =
                                  !controller.todoListModel[index].star;
                              if (controller.todoListModel[index].star ==
                                  true) {
                                importantAddSnack();
                                controller.importantTodoList.add(
                                  controller.todoListModel[index],
                                );
                              } else {
                                importantDelSnack();
                                controller.importantTodoList.remove(
                                  controller.todoListModel[index],
                                );
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.star,
                              color:
                                  controller.todoListModel[index].star
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
          );
        }),
      ),
    );
  }

  // == Functions ==
  rebuildData() {
    if (Message.action == true) {
      controller.addTodo(
        TodoListModel(
          imagePath: Message.imagePath,
          workList: Message.workList,
          category: Message.category,
          check: Message.check,
          date: Message.date,
          star: Message.star,
        ),
      );
      Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
    }
  }
}


buttonSnack() {
  Get.snackbar(
    '알림', // 변수도 넣을 수 있다
    '일정이 휴지통으로 이동되었습니다',
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

importantDelSnack(){
    Get.snackbar(
    '중요일정이 해제되었습니다.', // 변수도 넣을 수 있다
    '중요일정은 목록에서도 삭제되었습니다.',
    snackPosition: SnackPosition.BOTTOM, // BOTTOM
    duration: Duration(seconds: 2),
    backgroundColor: Colors.red,
    colorText: Colors.white,
    );
}