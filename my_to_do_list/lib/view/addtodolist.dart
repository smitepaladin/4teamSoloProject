import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    todate = DateTime.now();
    selectDateText = "";
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
                  Text('구매'),
                  Switch(
                    value: Message.switchBuy,
                    onChanged: (value) {
                      Message.switchBuy = value;
                      addViewSwitchBuy();
                    },
                  ),
                  Image.asset(
                    'images/cart.png',
                    height: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('약속'),
                  Switch(
                    value: Message.switchPromise,
                    onChanged: (value) {
                      Message.switchPromise = value;
                      addViewSwitchPromise();
                    },
                  ),
                  Image.asset(
                    'images/clock.png',
                    height: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('스터디'),
                  Switch(
                    value: Message.switchStudy,
                    onChanged: (value) {
                      Message.switchStudy = value;
                      addViewSwitchStudy();
                    },
                  ),
                  Image.asset(
                    'images/pencil.png',
                    height: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: '상세일정을 입력하세요',
                  ),
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
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: () {
                    if(textEditingController.text.trim().isNotEmpty){
                      addList();
                    }
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }//build
  // -- functions --


  addViewSwitchBuy(){
    if(Message.switchBuy == true){
      Message.switchPromise = false;
      Message.switchStudy = false;
      Message.imagePath = 'images/cart.png';
      setState(() {});
    }    
  }
  addViewSwitchPromise(){
    if(Message.switchPromise == true){
      Message.switchBuy = false;
      Message.switchStudy = false;
      Message.imagePath = 'images/clock.png';
      setState(() {});
    }    
  }
  addViewSwitchStudy(){
    if(Message.switchStudy == true){
      Message.switchBuy = false;
      Message.switchPromise = false;
      Message.imagePath = 'images/pencil.png';
      setState(() {});
    }    
  }


    dispDatePicker() async{ // 기본적으로 async
    // print(date.year);
    int firstYear = todate.year - 1;
    int lastYear = firstYear + 5;
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: todate, // 오늘날자를 첫화면에 보여줌
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Locale('ko','KR'), // 메인에 localizationsDelegates 없이 사용 불가능
    );
    
    if(selectedDate != null){
      selectDateText = "선택하신 일자는 ${selectedDate.toString().substring(0,10)} 입니다.";
      setState(() {});
      Message.date = selectedDate;
    }
    
  }


  addList(){
    Message.workList = textEditingController.text;
    Message.imagePath;
    Message.date;
    Message.action = true;

  
  }



}//class