import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/view/todo_list_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _EnterState();
}

class _EnterState extends State<Login> {
  late TextEditingController idController; // 아이디 입력필드
  late TextEditingController pwController; // 패스워드 입력필드

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Log in', style: TextStyle(fontSize: 30)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('images/todo.webp'),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: '사용자 ID를 입력하세요',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pwController,
                  decoration: InputDecoration(
                    labelText: '패스워드를 입력하세요',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => loginCheck(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Log in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // build

  /// == functions == ///

  loginCheck() { // 빈칸 입력 및 아이디 패스 워드 체크
    if (idController.text != Message.id || pwController.text != Message.pw) {
      Get.snackbar(
        '확인해주세요', 
        '아이디 혹은 비밀번호가 틀립니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red, // 부정메시지 송출은 빨간색
        colorText: Colors.white,
      );
    } else if (idController.text == Message.id ||
        pwController.text == Message.pw) {
      Get.snackbar(
        '환영합니다',
        '로그인에 성공하셨습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue, // 긍정메시지 송출은 파란색
        colorText: Colors.white,
      );
      Get.offAll(TodoListMain()); // 메인으로 보내기
    }
  }
}//Class