import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/controller/todoListController.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/addtodolist.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';
import 'package:my_to_do_list/view/recycle_bin.dart';
import 'package:my_to_do_list/view/login.dart';
import 'package:my_to_do_list/view/profile.dart';


class TodoListMain extends StatefulWidget {
  const TodoListMain({super.key});

  @override
  State<TodoListMain> createState() => _TodoListMainState();
}

class _TodoListMainState extends State<TodoListMain> {
  final TodoListController controller = Get.put(TodoListController());

  @override
  void initState() {
    super.initState();
    // 데이터 초기화 또는 불러오기 등의 작업은 여기서 처리할 수 있습니다.
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
      body: Center(
        child: Obx(() {  // Obx를 사용하여 controller의 todoListModel이 변경될 때마다 UI가 업데이트되도록 함
          return ListView.builder(
            itemCount: controller.todoListModel.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
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
                  child: Icon(
                    Icons.delete_forever,
                    size: 50,
                  ),
                ),
                child: GestureDetector(
                  onTap: () async {
                    Message.imagePath = controller.todoListModel[index].imagePath;
                    Message.workList = controller.todoListModel[index].workList;
                    Message.date = controller.todoListModel[index].date;
                    Message.category = controller.todoListModel[index].category;
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
                              controller.todoListModel[index].imagePath,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              controller.todoListModel[index].workList,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              controller.todoListModel[index].date.toString().substring(0, 10),
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
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/avatar.jpg'),
              ),
              accountName: Text(Message.id),
              accountEmail: Text('Pickachu@naver.com'),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.yard_outlined),
              title: Text('프로필보기'),
              onTap: () {
                Get.to(Profile());
              },
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('오늘의 일정'),
              onTap: () {
                Get.to(TodoListMain());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.recycling,
                color: Colors.red,
              ),
              title: Text('휴지통'),
              onTap: () {
                Get.to(RecycleBin());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              title: Text('로그아웃'),
              onTap: () {
                Get.offAll(Login());
                logOutSnack();
              },
            ),
          ],
        ),
      ),
    );
  }

  // == Functions ==
  rebuildData() {
    if (Message.action == true) {
      controller.addTodo(TodoListModel(
        imagePath: Message.imagePath,
        workList: Message.workList,
        category: Message.category,
        date: Message.date,
      ));
      Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
    }
  }
}


  logOutSnack(){
    Get.snackbar(
      '알림', // 변수도 넣을 수 있다
      '로그아웃 되었습니다',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white
    );
  }


  buttonSnack(){
    Get.snackbar(
      '알림', // 변수도 넣을 수 있다
      '일정이 휴지통으로 이동되었습니다',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white
    );
  }





  