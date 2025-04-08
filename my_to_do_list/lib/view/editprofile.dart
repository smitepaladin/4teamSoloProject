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
    profileImageName = "";
    nameController = TextEditingController();
    emailController = TextEditingController();
    detailController = TextEditingController();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 수정하기'),
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
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: '이름을 입력하세요'
              ),
              keyboardType: TextInputType.text,
              maxLines: 1, // 한줄이상 못쓴다.
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: '이메일을 입력하세요'
              ),
              keyboardType: TextInputType.emailAddress,
              maxLines: 1, // 한줄이상 못쓴다.
            ),
            TextField(
              controller: detailController,
              decoration: InputDecoration(
                labelText: '자기소개를 입력하세요'
              ),
              keyboardType: TextInputType.text,
              maxLines: 2, // 2줄이상 못쓴다.
            ),
            ElevatedButton(
              onPressed: () => editProfile(),
              child: Text('프로필 수정하기'),
            ),
          ],
        ),
      ),
    );
  }// build

  // == functions ==

  editProfile(){
    Message.profileImagepath = profileImagepath;
    Message.profileName = nameController.text;
    Message.profileEmail = emailController.text;
    Message.profileDetail = detailController.text;
    setState(() {});
    Get.to(Profile());
  }

}// Class