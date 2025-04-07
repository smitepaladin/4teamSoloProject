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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Message.imagePath
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Message.workList
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Message.date.toString().substring(0,10)
              ),
            ),
          ],
        ),
      ),
    );
  }
}