import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';

class DetailTodoList extends StatefulWidget {
  const DetailTodoList({super.key});

  @override
  State<DetailTodoList> createState() => _DetailTodoListState();
}

class _DetailTodoListState extends State<DetailTodoList> {

  late TextEditingController textEditingController; // 이미 입력되어있는 일정상세값을 변경할 수 있는 텍스트필드
  late DateTime todate; // date변수를 받기 위한 변수 추가
  late String selectDateText; // date변수값을 년/월/일 로 표현한 String 타입 변수
  late int radioValue; // Radio Button 변수
  late String imagePath; // 이미지 파일명 변수
  late String workList; // 일정 상세값 변수


  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.text = Message.workList;
    todate = Message.date;
    radioValue = getCategoryRadioValue(Message.category); // 이미 선택된 카테고리 값을 function을 통해 radioValue값을 뽑아낸다.
    selectDateText = "선택하신 일자는 ${Message.date.toString().substring(0, 10)} 입니다.";
    imagePath = Message.imagePath;
    workList = Message.workList;
  }  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일정 수정'),
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
                  onPressed: () => dispDatePicker(), // 달력 만들어내는 function
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
                    if (textEditingController.text.trim().isNotEmpty) { // 상세일정 미입력시 걸러내는 조건문
                      _showDialog(); // 변경된 변수들을 실제로 반영하는 function
                    } else {
                      Get.snackbar(
                        '알림', 
                        '상세일정을 입력하세요.',
                        snackPosition: SnackPosition.BOTTOM, 
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Text('일정수정'),
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
          todate = selectedDate;
      setState(() {});
      
    }
  }

  radioChange(int? value) {
    // value값이 위에서 ? 상태여서 ? 로 받았다
    radioValue = value!; // !는 ? 를 해제한다
    setState(() {});
  }
  String getCatetory(int radioValue) { // 카테고리 문자열 변수를 뽑아내는 function
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

  String getImagepath(int radioValue) { // 이미지 파일명을 뽑아내는 fucintion
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

  int getCategoryRadioValue(String category) { // 문자열 변수를 통해 RadioValue값을 뽑는 function
  switch (category) {
    case "구매":
      return 0;
    case "약속":
      return 1;
    case "스터디":
      return 2;
    case "식사":
      return 3;
    default:
      return 0;  // 기본값으로 "구매" 설정
  }
}


_showDialog() {
  Message.category = getCatetory(radioValue);
  Message.imagePath = getImagepath(radioValue);
  Message.workList = textEditingController.text;
  Message.date = todate;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          '일정 수정하기',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(
          '선택하신 카테고리는 ${Message.category} 입니다. \n'
          '상세내용은 ${Message.workList} 입니다. \n'
          '선택하신 일자는 ${Message.date.toString().substring(0, 10)} 입니다. \n'
          '일정을 수정 하시겠습니까?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              editList(); // 수정 함수
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

editList() {
  // 수정된 값을 Message 객체에 반영
  Message.workList = textEditingController.text;
  Message.imagePath = getImagepath(radioValue);
  Message.category = getCatetory(radioValue);
  Message.date = todate;
  Message.action = true; // 수정이 완료되었음을 알림
}

  buttonSnack() { // 일정수정 알림 스낵바
    Get.snackbar(
      '알림',
      '일정이 수정되었습니다',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      
    );

  }
  
}