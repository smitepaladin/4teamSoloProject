import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/view/editprofile.dart';
import 'package:my_to_do_list/view/menudrawer.dart';
import 'package:my_to_do_list/model/messege.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
      ),
      drawer: Menudrawer(),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              Message.profileImagepath
            ),
            Text(Message.profileName),
            Text(Message.profileEmail),
            Text(Message.profileDetail),
            ElevatedButton(
              onPressed: () => Get.to(Editprofile()),
              child: Text('프로필 수정하기')
            )
          ],
        ),
      ),
    );
  }
}