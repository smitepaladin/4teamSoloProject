class ImportantModel {
  //Property


  String importantimagePath; // 이미지 파일 주소와 파일명
  String importantworkList; // 사용자 일정 입력값
  String importantcategory;
  bool importantcheck;
  bool importantstar;
  DateTime importantdate; // 캘린더에서 뽑아올 시간



  // Constructer

  ImportantModel(
    {
      required this.importantimagePath,
      required this.importantworkList,
      required this.importantcategory,
      required this.importantcheck,
      required this.importantstar,
      required this.importantdate
    }


  );
}