import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';


class Addtodolist extends StatefulWidget {
  const Addtodolist({super.key});

  @override
  State<Addtodolist> createState() => _AddtodolistState();
}

class _AddtodolistState extends State<Addtodolist> {
  late TextEditingController textEditingController; // 상세일정을 받는 텍스트필드
  late DateTime todate; // 선택한 날짜의 날짜 변수
  late String selectDateText; // date변수값을 년/월/일 로 표현한 String 타입 변수
  late int radioValue; // Radio Button 변수
  late String imagePath; // 이미지 파일명 변수
  late String workList;// 일정 상세값 변수

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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('images/cart.png', width: 40),
                          Text('구매'),
                          Radio(
                            value: 0,
                            groupValue: radioValue,
                            onChanged:
                                (value) => radioChange(value),
                          ),
                        ],
                      ),
                    ),
          
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('images/clock.png', width: 40),
                          Text('약속'),
                          Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged:
                                (value) => radioChange(value), 
                          ),
                        ],
                      ),
                    ),
          
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('images/pencil.png', width: 40),
                          Text('스터디'),
                          Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged:
                                (value) => radioChange(value), 
                          ),
                        ],
                      ),
                    ),
          
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('images/eat.avif', width: 40),
                          Text('식사'),
                          Radio(
                            value: 3,
                            groupValue: radioValue,
                            onChanged:
                                (value) => radioChange(value), 
                          ),
                        ],
                      ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),                  
                    onPressed: () => dispDatePicker(),
                    child: Text('달력에서 날짜선택'),
                  ),
                ),
                Text(selectDateText),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,100,20,20),
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
                      } else {
                        Get.snackbar(
                          '알림', 
                          '상세일정을 입력하세요.',
                          snackPosition: SnackPosition.BOTTOM, // BOTTOM
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Text('일정추가'),
                  ),
                ),
              ],
            ),
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
          todate = selectedDate;
      setState(() {});
      
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
    Message.workList = textEditingController.text; 
    Message.date = todate; 

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
                addList(); // 리스트 추가 function
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

  String getCatetory(int radioValue) { // 선택된 radioValuer값으로 카테고리명 반영
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

  String getImagepath(int radioValue) { // 선택된 radioValuer값으로 이미지 파일명 반영
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
        imagePathreturnValue = "images/eat.avif";
        break;
    }
    return imagePathreturnValue;
  }

  addList() { // 추가된 값을 Message 객체에 반영
    Message.workList = textEditingController.text;
    Message.imagePath;
    Message.category;
    Message.date;
    Message.action = true;
  }

  buttonSnack() { // 일정추가 알림 스낵바
    Get.snackbar(
      '알림',
      '일정이 추가되었습니다',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      
    );

  }
}//class