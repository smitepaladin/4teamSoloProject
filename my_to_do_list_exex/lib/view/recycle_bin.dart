import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/view/addtodolist.dart';
import 'package:my_to_do_list/view/detail_todo_list.dart';
import 'package:my_to_do_list/view/login.dart';
import 'package:my_to_do_list/view/profile.dart';
import 'package:my_to_do_list/model/recycle_model.dart';

class RecycleBin extends StatefulWidget {
  const RecycleBin({super.key});

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  late List<RecycleModel> recycleListModel;


  @override
  void initState() {
    super.initState();
    recycleListModel = [];
    // addData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: recycleListModel.length,
          itemBuilder: (context, index) {
            return Dismissible(
                direction: DismissDirection.endToStart,
                key: ValueKey(recycleListModel[index]),
                onDismissed: (direction) {
                  recycleListModel.remove(recycleListModel[index]);
                  setState(() {});
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
              child: GestureDetector( // 카드는 터치기능이 없다. 그래서 제스쳐디텍터를 넣어줘야한다.
                onTap: () async{
                  Message.imagePath = todoListModel[index].imagePath;
                  Message.workList = todoListModel[index].workList; // message.dart에서 선언한 Static Class
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
                            todoListModel[index].imagePath,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: Text(
                            todoListModel[index].workList,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: Text(
                            todoListModel[index].date.toString().substring(0,10)
                          )
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/avatar.jpg'),
              ),
              accountName: Text(Message.idpw[0].id),
              accountEmail: Text('Pickachu@naver.com'),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.yard_outlined
              ),
              title: Text('프로필보기'),
              onTap:() {
                Get.to(Profile());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.today
              ),
              title: Text('오늘의 일정'),
              onTap:() {
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.recycling,
                color: Colors.red,
              ),
              title: Text('삭제된 일정'),
              onTap:() {
                //
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              title: Text('로그아웃'),
              onTap:() {
                Get.off(Login());
              },
            ),
          ],
        )
      ),      
    );
  }//build

  // == Functions ==

  rebuildData(){
    if(Message.action == true){
      todoListModel.add(TodoListModel(imagePath: Message.imagePath, workList: Message.workList, date: Message.date));
      Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
    }
    
    setState(() {});
  }
}//Class