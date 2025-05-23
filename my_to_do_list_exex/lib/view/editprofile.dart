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

  late String profileImagepath; // 이미지 파일의 파일명 변수
  late String profileImageName; // 이미지 파일 동물의 이름 변수
  late TextEditingController nameController; // 이름을 입력받는 텍스트 필드
  late TextEditingController emailController; // 이메일을 입력받는 텍스트 필드
  late TextEditingController detailController; // 자기소개를 입력받는 텍스트필드


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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal, // 사진 목록들이며 스와이프 가능
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
              Text(profileImageName), // 선택한 사진이 무엇인지 알 수 있게 동물이름 표시
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController, // 이름 입력필드
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
                  decoration: InputDecoration(  // 이메일 입력필드
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
                  controller: detailController, // 자기소개 입력 필드
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
                  onPressed: () => editProfile(), // 수정 시 변수들을 추가하는 function
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  child: Text('프로필 수정하기'),              
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }// build

  // == functions ==



  editProfile() {
  if (nameController.text.trim().isEmpty || emailController.text.trim().isEmpty || detailController.text.trim().isEmpty || profileImagepath.trim().isEmpty) {
    // 빈 입력값이 있을 경우, '입력값을 확인하세요' 메시지와 함께 Snackbar 출력
    Get.snackbar(
    '알림', 
    '입력값을 확인하세요.',
    snackPosition: SnackPosition.BOTTOM, 
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