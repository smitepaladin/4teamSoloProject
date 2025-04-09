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
        title: Text('일정 상세'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              Message.imagePath,
              width: 100, 
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20), 
      

          Text(
            Message.category,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,

            ),
          ),
          SizedBox(height: 10), // 카테고리와 작업 리스트 사이 여백
      
          // 작업 리스트 텍스트
          Text(
            Message.workList,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20), // 작업 리스트와 날짜 사이 여백
      
          // 날짜 텍스트
          Text(
            Message.date.toString().substring(0, 10),
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 30), // 하단 여백
        ],
      ),
      )
      
    );
  }
}