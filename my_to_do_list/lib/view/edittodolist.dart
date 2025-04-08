import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_list/model/messege.dart';

class Edittodolist extends StatefulWidget {
  const Edittodolist({super.key});

  @override
  State<Edittodolist> createState() => _EdittodolistState();
}

class _EdittodolistState extends State<Edittodolist> {
  late TextEditingController textEditingController;
  late DateTime todate;
  late String selectDateText;
  late int radioValue; // Radio Button
  late String imagePath;
  late String workList;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: Message.workList);
    todate = Message.date;
    radioValue = _getCategoryValue(Message.category);
    selectDateText = "선택하신 일자는 ${todate.toString().substring(0, 10)} 입니다.";
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
                  _categoryColumn(0, '구매', 'images/cart.png'),
                  _categoryColumn(1, '약속', 'images/clock.png'),
                  _categoryColumn(2, '스터디', 'images/pencil.png'),
                  _categoryColumn(3, '식사', 'images/eat.jpeg'),
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
                  child: Text('수정 완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 카테고리 선택을 위한 Column
  Widget _categoryColumn(int value, String label, String image) {
    return Column(
      children: [
        Image.asset(image, width: 40),
        Text(label),
        Radio(
          value: value,
          groupValue: radioValue,
          onChanged: (value) => radioChange(value),
        ),
      ],
    );
  }

  dispDatePicker() async {
    int firstYear = todate.year - 1;
    int lastYear = firstYear + 5;
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: todate,
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Locale('ko', 'KR'),
    );

    if (selectedDate != null) {
      selectDateText =
          "선택하신 일자는 ${selectedDate.toString().substring(0, 10)} 입니다.";
      setState(() {});
      Message.date = selectedDate;
    }
  }

  radioChange(int? value) {
    radioValue = value!;
    setState(() {});
  }

  // 기존 카테고리 값에 맞는 radioValue 반환
  int _getCategoryValue(String category) {
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
        return 0;
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
              updateList(); // 수정 후 리스트 업데이트
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
    switch (radioValue) {
      case 0:
        return "구매";
      case 1:
        return "약속";
      case 2:
        return "스터디";
      case 3:
        return "식사";
      default:
        return "";
    }
  }

  String getImagepath(int radioValue) {
    switch (radioValue) {
      case 0:
        return "images/cart.png";
      case 1:
        return "images/clock.png";
      case 2:
        return "images/pencil.png";
      case 3:
        return "images/eat.jpeg";
      default:
        return "";
    }
  }

  // 리스트 수정 함수
  updateList() {
    Message.workList = textEditingController.text;
    Message.imagePath;
    Message.category;
    Message.date;
    Message.action = true;
    setState(() {}); // 상태 갱신
  }

  buttonSnack() {
    Get.snackbar(
      '알림', 
      '일정이 수정되었습니다',
      snackPosition: SnackPosition.BOTTOM, 
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white
    );
  }
}