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
            // ElevatedButton(
            // onPressed: () async{
            //   await Get.to(Signup());
            //   rebuildData();
            // },
            //   child: Text('Sign up')
            // ),
          ],
        ),
      ),
    );
  }// build

  /// == functions == ///
  

  loginCheck(){
    if(idController.text != Message.id || pwController.text != Message.pw){
      Get.snackbar(
        '다시 확인해 주세요',
        '아이디 또는 비밀번호가 틀립니다'
      );
    }else if(idController.text == Message.id || pwController.text == Message.pw){
      Get.snackbar(
        '환영합니다',
        '${Message.id}님',
        duration: Duration(seconds: 1),
      );
      Get.offAll(TodoListMain()); 
    }
  }


  rebuildData(){
    // if(Message.action == true){
    //   userListmodel.add(UserListmodel(id: Message.idpw[].id, pw: Message.pw));
    //   Message.action = false; // 데이터를 넣었으니 너는 옛날 데이터야
    // }
    
    // setState(() {});
  }



  // buttonSnack(){
  //   Get.snackbar(
  //     '환영합니다', // 변수도 넣을 수 있다
  //     '신분이 확인되었습니다.',
  //     snackPosition: SnackPosition.TOP, // BOTTOM
  //     duration: Duration(seconds: 2),
  //     backgroundColor: Colors.red,
  //     colorText: Colors.white,
      
  //   );
    
  // }

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
  //               Get.off(TodoListMain());
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


}//Class