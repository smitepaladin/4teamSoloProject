import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';


class Addtodolist extends StatefulWidget {
  const Addtodolist({super.key});

  @override
  State<Addtodolist> createState() => _AddtodolistState();
}

class _AddtodolistState extends State<Addtodolist> {
  late TextEditingController textEditingController;
  late DateTime todate;
  late String selectDateText;
  late int radioValue; // Radio Button
  late String imagePath;
  late String workList;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    todate = DateTime.now();
    radioValue = 0;
    selectDateText = "";
    imagePath = "";
    workList = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일정추가'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset('images/cart.png', width: 40),
                      Text('구매'),
                      Radio(
                        value: 0,
                        groupValue: radioValue,
                        onChanged:
                            (value) => radioChange(value), // value값이 ? 상태이다
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Image.asset('images/clock.png', width: 40),
                      Text('약속'),
                      Radio(
                        value: 1,
                        groupValue: radioValue,
                        onChanged:
                            (value) => radioChange(value), // value값이 ? 상태이다
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Image.asset('images/pencil.png', width: 40),
                      Text('스터디'),
                      Radio(
                        value: 2,
                        groupValue: radioValue,
                        onChanged:
                            (value) => radioChange(value), // value값이 ? 상태이다
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Image.asset('images/eat.jpeg', width: 40),
                      Text('식사'),
                      Radio(
                        value: 3,
                        groupValue: radioValue,
                        onChanged:
                            (value) => radioChange(value), // value값이 ? 상태이다
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(labelText: '상세일정을 입력하세요'),
                  keyboardType: TextInputType.text,
                ),
              ),
              ElevatedButton(
                onPressed: () => dispDatePicker(),
                child: Text('Date Picker'),
              ),
              Text(selectDateText),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    if (textEditingController.text.trim().isNotEmpty) {
                      _showDialog();
                    }
                  },
                  child: Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } //build
  // -- functions --

  dispDatePicker() async {
    // 기본적으로 async

    int firstYear = todate.year - 1;
    int lastYear = firstYear + 5;
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: todate, // 오늘날자를 첫화면에 보여줌
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Locale('ko', 'KR'), // 메인에 localizationsDelegates 없이 사용 불가능
    );

    if (selectedDate != null) {
      selectDateText =
          "선택하신 일자는 ${selectedDate.toString().substring(0, 10)} 입니다.";
      setState(() {});
      Message.date = selectedDate;
    }
  }

  radioChange(int? value) {
    // value값이 위에서 ? 상태여서 ? 로 받았다
    radioValue = value!; // !는 ? 를 해제한다
    setState(() {});
  }

  _showDialog() {
    // 필요한 값을 Message 객체에 설정
    Message.category = getCatetory(radioValue);
    Message.imagePath = getImagepath(radioValue);
    Message.workList = textEditingController.text; // 이 부분에서 상세 일정을 넣어줘야 함
    Message.date = todate; // or selectedDate if you want the selected date

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '일정 추가하기',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            '선택하신 카테고리는 ${Message.category} 입니다. \n'
            '상세내용은 ${Message.workList} 입니다. \n'
            '선택하신 일자는 ${Message.date.toString().substring(0, 10)} 입니다. \n'
            '일정을 추가 하시겠습니까?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                addList(); // 리스트 추가 후 Dialog 닫기
                Navigator.of(context).pop(); // Dialog 닫기
                buttonSnack();
              },
              child: Text('예'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog 닫기
              },
              child: Text('아니오'),
            ),
          ],
        );
      },
    );
  }

  String getCatetory(int radioValue) {
    String catogoryReturnValue = "";

    switch (radioValue) {
      case 0:
        catogoryReturnValue = "구매";
        break;
      case 1:
        catogoryReturnValue = "약속";
        break;
      case 2:
        catogoryReturnValue = "스터디";
        break;
      case 3:
        catogoryReturnValue = "식사";
        break;
    }
    return catogoryReturnValue;
  }

  String getImagepath(int radioValue) {
    String imagePathreturnValue = "";

    switch (radioValue) {
      case 0:
        imagePathreturnValue = "images/cart.png";
        break;
      case 1:
        imagePathreturnValue = "images/clock.png";
        break;
      case 2:
        imagePathreturnValue = "images/pencil.png";
        break;
      case 3:
        imagePathreturnValue = "images/eat.jpeg";
        break;
    }
    return imagePathreturnValue;
  }

  addList() {
    Message.workList = textEditingController.text;
    Message.imagePath;
    Message.category;
    Message.date;
    Message.action = true;
  }

  buttonSnack(){
    Get.snackbar(
      '알림', 
      '일정이 추가되었습니다',
      snackPosition: SnackPosition.BOTTOM, 
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white
    );
  }


}//class