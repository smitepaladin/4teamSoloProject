import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';
import 'package:my_to_do_list/view/profile.dart';


class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {

  late String profileImagepath;
  late String profileImageName;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController detailController;


  @override
  void initState() {
    super.initState();
    profileImagepath = "";
    profileImageName = "그림을 스와이프해서 사진을 선택해 주세요.";
    nameController = TextEditingController();
    emailController = TextEditingController();
    detailController = TextEditingController();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 수정하기'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/cow.png';
                      profileImageName = "젖소";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/cow.png',
                      width: 80,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/pig.png';
                      profileImageName = "돼지";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/pig.png',
                      width: 80,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/bee.png';
                      profileImageName = "벌";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/bee.png',
                      width: 80,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/fox.png';
                      profileImageName = "여우";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/fox.png',
                      width: 80,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/cat.png';
                      profileImageName = "고양이";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/cat.png',
                      width: 80,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/wolf.png';
                      profileImageName = "늑대";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/wolf.png',
                      width: 80,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/monkey.png';
                      profileImageName = "원숭이";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/monkey.png',
                      width: 80,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      profileImagepath = 'images/dog.png';
                      profileImageName = "개";
                      setState(() {});
                    },
                    child: Image.asset(
                      'images/dog.png',
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
            Text(profileImageName),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '이름을 입력하세요',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                ),
                keyboardType: TextInputType.text,
                maxLines: 1, // 한줄이상 못쓴다.
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: '이메일을 입력하세요',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),                
                ),
                keyboardType: TextInputType.emailAddress,
                maxLines: 1, // 한줄이상 못쓴다.
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: detailController,
                decoration: InputDecoration(
                  labelText: '자기소개를 입력하세요',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),                
                ),
                keyboardType: TextInputType.text,
                maxLines: 1, // 1줄이상 못쓴다.
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,100,8,8),
              child: ElevatedButton(
                onPressed: () => editProfile(),
                child: Text('프로필 수정하기'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),              
              ),
            ),
          ],
        ),
      ),
    );
  }// build

  // == functions ==

  // editProfile(){
  //   Message.profileImagepath = profileImagepath;
  //   Message.profileName = nameController.text;
  //   Message.profileEmail = emailController.text;
  //   Message.profileDetail = detailController.text;
  //   setState(() {});
  //   Get.to(Profile());
  // }


  editProfile() {
  // 만약 이름, 이메일, 자기소개, 혹은 이미지 경로가 비어있다면
  if (nameController.text.trim().isEmpty || emailController.text.trim().isEmpty || detailController.text.trim().isEmpty || profileImagepath.trim().isEmpty) {
    // 빈 입력값이 있을 경우, '입력값을 확인하세요' 메시지와 함께 Snackbar 출력
    Get.snackbar(
    '알림', // 변수도 넣을 수 있다
    '입력값을 확인하세요.',
    snackPosition: SnackPosition.BOTTOM, // BOTTOM
    duration: Duration(seconds: 2),
    backgroundColor: Colors.red,
    colorText: Colors.white,
    );
  }else{

  // 모든 값이 입력되었다면, 프로필 정보를 업데이트하고 Profile 화면으로 이동
  Message.profileImagepath = profileImagepath;
  Message.profileName = nameController.text;
  Message.profileEmail = emailController.text;
  Message.profileDetail = detailController.text;
  setState(() {});
  Get.to(Profile());
    }
  }

}// Class