class TodoListModel {
  //Property


  String imagePath; // 이미지 파일 주소와 파일명
  String workList; // 사용자 일정 입력값
  String category;
  bool check;
  bool star;
  DateTime date; // 캘린더에서 뽑아올 시간



  // Constructer

  TodoListModel(
    {
      required this.imagePath,
      required this.workList,
      required this.category,
      required this.check,
      required this.star,
      required this.date
    }


  );
}