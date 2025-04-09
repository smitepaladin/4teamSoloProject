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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Menudrawer(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Message.profileImagepath),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Message.profileName, style: TextStyle(fontSize: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Message.profileEmail, style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Message.profileDetail,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
              child: ElevatedButton(
                onPressed: () => Get.to(Editprofile()),
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
    );
  }
}
