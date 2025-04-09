import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/menudrawer.dart';

class RecycleBin extends StatefulWidget {
  const RecycleBin({super.key});

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('휴지통'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Menudrawer(),
      body:
          Message.recycleListModel.isEmpty
              ? Center(
                child: Text(
                  '삭제된 일정이 없습니다.',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              )
              : ListView.builder(
                itemCount: Message.recycleListModel.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: ValueKey(Message.recycleListModel[index]),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        Message.recycleListModel.removeAt(index);
                        setState(() {});
                        buttonSnack();
                      } else if (direction == DismissDirection.startToEnd) {
                        Message.todoListModel.add(
                          TodoListModel(
                            imagePath:
                                Message.recycleListModel[index].imagePath,
                            workList: Message.recycleListModel[index].workList,
                            category: Message.recycleListModel[index].category,
                            check: Message.recycleListModel[index].check,
                            star: Message.recycleListModel[index].star,
                            date: Message.recycleListModel[index].date,
                          ),
                        );

                        Message.recycleListModel.removeAt(index);
                        setState(() {});

                        buttonRecycleSnack();
                      }
                    },
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.restore_from_trash, size: 50),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.delete_forever,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          Message.recycleListModel[index].imagePath,
                          width: 50,
                        ),
                        title: Text(Message.recycleListModel[index].workList),
                        subtitle: Text(
                          '${Message.recycleListModel[index].category} | ${Message.recycleListModel[index].date.toString().substring(0, 10)}',
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  } // build

  // functions //
  buttonSnack() {
    Get.snackbar(
      '알림', // 변수도 넣을 수 있다
      '일정이 완전히 삭제되었습니다.',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  buttonRecycleSnack() {
    Get.snackbar(
      '알림', // 변수도 넣을 수 있다
      '일정이 다시 복원되었습니다.',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
} //Class
