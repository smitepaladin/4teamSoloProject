import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {



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
        title: Text('계정추가'),
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
              onPressed: () => signUpCheck(),
              child: Text('계정추가')
            ),
          ],
        ),
      ),
    );
  }// build

  /// == functions == ///
  

  signUpCheck(){

  }

  // _showDialog(){
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context){
  //       return AlertDialog(
  //         title: Text('환영 합니다!'),
  //         content: Text('신분이 확인되었습니다.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Get.to(TodoListMain());
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


}//Class