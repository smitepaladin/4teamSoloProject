import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/controller/todoListController.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';
import 'package:my_to_do_list/view/menudrawer.dart';

class ImportantTodoList extends StatelessWidget {
  const ImportantTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoListController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("중요 일정"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Menudrawer(),
      body: Center(
        child: Obx(() {
          if (controller.importantTodoList.isEmpty) {
            return Center(
              child: Text(
                '중요 일정이 없습니다. 중요일정을 추가해주세요.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.importantTodoList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    controller.importantTodoList[index].imagePath,
                  ),
                  title: Text('${controller.importantTodoList[index].category} - ${controller.importantTodoList[index].workList}'),
                  subtitle: Text(
                    controller.importantTodoList[index].date
                        .toString()
                        .substring(0, 10),
                  ),
                  trailing: Icon(
                    Icons.star,
                    color:
                        controller.importantTodoList[index].star
                            ? Colors.yellow
                            : Colors.grey,
                  ),
                  onTap: () {
                    Get.to(
                      DetailTodoList(),
                      arguments: controller.importantTodoList[index],
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
