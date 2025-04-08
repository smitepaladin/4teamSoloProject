import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/view/important_todolist.dart';
import 'package:my_to_do_list/view/recycle_bin.dart';
import 'package:my_to_do_list/view/login.dart';
import 'package:my_to_do_list/view/profile.dart';
import 'package:my_to_do_list/view/todo_list_main.dart';

class Menudrawer extends StatelessWidget {
  const Menudrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(Message.profileImagepath),
              ),
              accountName: Text(Message.profileName),
              accountEmail: Text(Message.profileEmail),
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
                Get.off(Profile());
              },
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('오늘의 일정'),
              onTap: () {
                Get.off(TodoListMain());
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('중요일정'),
              onTap: () {
                Get.to(ImportantTodoList());
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
      );

  }// build
// functions //

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


}//Class