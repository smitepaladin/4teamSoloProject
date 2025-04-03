import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/view/signup.dart';
import 'package:my_to_do_list/view/todo_list_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _EnterState();
}

class _EnterState extends State<Login> {

  late TextEditingController idController;
  late TextEditingController pwController;



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
        title: Text('Log in'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'images/avatar.jpg'
            ),

            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: '사용자 ID를 입력하세요'
              ),
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),

            TextField(
              controller: pwController,
              decoration: InputDecoration(
                labelText: '패스워드를 입력하세요',
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            ElevatedButton(
              onPressed: () => loginCheck(),
              child: Text('Log in')
            ),
            ElevatedButton(
              onPressed: () => Get.to(Signup()),
              child: Text('Sign up')
            ),
          ],
        ),
      ),
    );
  }// build

  /// == functions == ///
  

  loginCheck(){
    if(idController.text == "Admin" && pwController.text == "1234"){
      _showDialog();
    }else{
      Navigator.pushNamed(context, '/');
    }
  }

  _showDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('환영 합니다!'),
          content: Text('신분이 확인되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(TodoListMain());
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


}//Class