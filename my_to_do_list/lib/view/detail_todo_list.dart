import 'package:flutter/material.dart';
import 'package:my_to_do_list/model/messege.dart';

class DetailTodoList extends StatefulWidget {
  const DetailTodoList({super.key});

  @override
  State<DetailTodoList> createState() => _DetailTodoListState();
}

class _DetailTodoListState extends State<DetailTodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일정상세'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Message.imagePath),
            Text(Message.workList),
            Text(Message.date.toString().substring(0, 10)),
          ],
        ),
      ),
    );
  }
}
