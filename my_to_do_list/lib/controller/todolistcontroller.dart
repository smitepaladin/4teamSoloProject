import 'package:get/get.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';

class TodoListController extends GetxController {
  var todoListModel = <TodoListModel>[].obs;
  var importantTodoList = <TodoListModel>[].obs; // 중요 일정을 위한 리스트 추가

  // 데이터 추가
  void addTodo(TodoListModel todo) {
    todoListModel.add(todo);
  }

  // 데이터 삭제
  void removeTodo(TodoListModel todo) {
    todoListModel.remove(todo);
  }
}
