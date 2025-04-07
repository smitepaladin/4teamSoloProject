import 'package:flutter/material.dart';
import 'package:my_to_do_list/model/recycle_model.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/profile.dart';
import 'package:my_to_do_list/view/recycle_bin.dart';
import 'package:my_to_do_list/view/todo_list_main.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin { 

  //Property

  late TabController controller;
  late List<TodoListModel> todoListModel;// 제너릭은 모델인 TodolistModel
  late List<RecycleModel> recycleListModel;// 제너릭은  모델인 RecycleModel


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // 메인 프로필 중요일정 삭제일정,작업하면서 늘리자
    todoListModel = [];
    recycleListModel = [];
    // addData();
  }


  // addData(){

  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          TodoListMain(mainlist: todoListModel), //todo_list_main 연결
          Profile(mainlist: todoListModel),
          RecycleBin(recyclelist: recycleListModel),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        child: TabBar(
          controller: controller,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.red,
          tabs: [
            Tab(icon: Icon(Icons.looks_one)),
            Tab(icon: Icon(Icons.looks_two)),
            Tab(icon: Icon(Icons.looks_sharp)),
          ],
        ),
      ),
    );
  }// build
}//Class