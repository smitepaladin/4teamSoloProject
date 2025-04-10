import 'package:flutter/material.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/view/menudrawer.dart';

class ImportantTodolist extends StatelessWidget {
  const ImportantTodolist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('중요 일정'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Menudrawer(),
      body: Message.importantListModel.isEmpty // 중요 일정이 없는경우 안내 메시지 
          ? Center(
              child: Text(
                '중요 일정이 없습니다.',
                style: TextStyle(fontSize: 18, color: Colors.black45),
              ),
            )
          : ListView.builder(
              itemCount: Message.importantListModel.length,
              itemBuilder: (context, index) {
                final item = Message.importantListModel[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(item.imagePath, width: 50),
                    title: Text(item.workList),
                    subtitle: Text(
                      '${item.category} | ${item.date.toString().substring(0, 10)}',
                    ),
                    trailing: Icon(Icons.star, color: Colors.yellow),
                  ),
                );
              },
            ),
    );
  }
}