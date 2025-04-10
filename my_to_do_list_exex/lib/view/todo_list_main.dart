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
  late List<TodoListModel> todoListModel; // 일정 리스트

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
              rebuildData(); // 일정 추가에서 받아온 변수를 리스트에 추가해주는 function
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      drawer: Menudrawer(),
      body: Center(
        child:
            todoListModel.isEmpty // 일정이 없는 경우 안내 메시지
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
                                  .none // 중요 일정인 경우에는 스와이프 불가 = 삭제 불가
                              : DismissDirection.endToStart, // 일반 일정은 스와이프 가능 = 삭제 가능
                      key: ValueKey(todoListModel[index]),
                      onDismissed: (direction) {
                        Message.recycleListModel.add( // 삭제된 index 를 휴지통 리스트에 추가
                          RecycleModel(
                            imagePath: todoListModel[index].imagePath,
                            workList: todoListModel[index].workList,
                            category: todoListModel[index].category,
                            check: todoListModel[index].check,
                            star: todoListModel[index].star,
                            date: todoListModel[index].date,
                          ),
                        );

                        todoListModel.removeAt(index); // 넘기고 삭제
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
                              builder: (context) => DetailTodoList(), // 일정 수정 페이지로 이동
                            ),
                          ).then((value) => getData()); // 일정 수정에서 넘어온 변수를 리스트에 넣어주는 function, then으로 받아 순서 정리
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
                                Checkbox( // 체크박스는 단순 강조 용도
                                  value: todoListModel[index].check,
                                  onChanged: (value) {
                                    todoListModel[index].check = value!;
                                    setState(() {});
                                  },
                                ),
                                Image.asset(
                                  todoListModel[index].imagePath, // 이미지 파일명
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
                                              todoListModel[index].category, // 카테고리명
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              todoListModel[index].workList, // 일정 상세
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        todoListModel[index].date // 일정 날짜
                                            .toString()
                                            .substring(0, 10),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton( // 중요일정 여부를 결정하는 아이콘 버튼
                                  onPressed: () {
                                    todoListModel[index].star =
                                        !todoListModel[index].star;

                                    if (todoListModel[index].star == true) {
                                      importantAddSnack(); // 중요일정 추가 스낵바

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
                                      importantDelSnack(); // 중요일정 해제 스낵바

                                      Message.importantListModel.removeWhere( // 중요일정 해제시 중요일정 리스터에서 삭제
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

  rebuildData() { // 일정 추가시 리스트에 추가해주는 function
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

  getData() {// 일정 수정시 리스트에서 수정해주는 function
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


  snackbar(){ // 일정삭제 알림 스넥바
    Get.snackbar(
      '일정이 삭제되었습니다.', 
      '휴지통에서 복원이 가능합니다.',
      snackPosition: SnackPosition.BOTTOM, 
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  importantAddSnack() { // 중요일정 추가 알림 스낵바
    Get.snackbar(
      '중요일정이 추가되었습니다.', // 변수도 넣을 수 있다
      '중요일정은 삭제가 불가능합니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  importantDelSnack() { // 중요일정 해제 알림 스낵바
    Get.snackbar(
      '중요일정이 해제되었습니다.', 
      '중요일정 목록에서도 삭제되었습니다.',
      snackPosition: SnackPosition.BOTTOM, 
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}//Class