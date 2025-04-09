import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';
import 'package:my_to_do_list/view/menudrawer.dart';
import 'package:my_to_do_list/model/recycle_model.dart';
import 'package:my_to_do_list/controller/recyclebincontroller.dart';
import 'package:my_to_do_list/view/todo_list_main.dart';

class RecycleBin extends StatefulWidget {
  const RecycleBin({super.key});

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  final RecycleBinController controller = Get.put(RecycleBinController());
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
      controller.addToRecycleBin(
        RecycleModel(
          recycleimagePath: value.imagePath,
          recycleworkList: value.workList,
          recycledate: value.date,
          recyclecategory: value.category,
          recyclecheck: value.check,
          recyclestar: value.star
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("휴지통"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Menudrawer(),
      body: Center(
        child: Obx(() {
          if (controller.recycleListModel.isEmpty) {
            return Center(
              child: Text(
                '휴지통이 비었습니다.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.recycleListModel.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.horizontal,
                key: ValueKey(controller.recycleListModel[index]),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    controller.removeFromRecycleBin(
                      controller.recycleListModel[index],
                    );
                    buttonSnack();
                  } else if (direction == DismissDirection.startToEnd) {
                    Get.to(
                      TodoListMain(),
                      arguments: controller.recycleListModel[index],
                    );
                    controller.removeFromRecycleBin(
                      controller.recycleListModel[index],
                    );
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

                child: GestureDetector(
                  onTap: () async {
                    Message.recycleimagePath =
                        controller.recycleListModel[index].recycleimagePath;
                    Message.recycleworkList =
                        controller.recycleListModel[index].recycleworkList;
                    Message.recycledate =
                        controller.recycleListModel[index].recycledate;
                    Message.recyclecategory =
                        controller.recycleListModel[index].recyclecategory;
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
                              controller
                                  .recycleListModel[index]
                                  .recycleimagePath,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              controller
                                  .recycleListModel[index]
                                  .recycleworkList,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              controller.recycleListModel[index].recycledate
                                  .toString()
                                  .substring(0, 10),
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
      controller.addToRecycleBin(
        RecycleModel(
          recycleimagePath: Message.recycleimagePath,
          recycleworkList: Message.recycleworkList,
          recycledate: Message.recycledate,
          recyclecategory: Message.category,
          recyclecheck: Message.check,
          recyclestar: Message.star
        ),
      );
      Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
    }
  }

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

  buttonRecycleSnack(){
    Get.snackbar(
      '알림', // 변수도 넣을 수 있다
      '일정이 다시 복원되었습니다.',
      snackPosition: SnackPosition.BOTTOM, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );    
  }
}
