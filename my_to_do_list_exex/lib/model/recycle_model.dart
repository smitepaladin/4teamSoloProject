class RecycleModel {
  //Property

  String imagePath; // 이미지 파일 주소와 파일명
  String workList; // 사용자 일정 입력값
  String category = ""; // 이미지 주소와 같이 붙어가는 카테고리명(ex : 스터디)
  bool check; // 체크박스 유무
  bool star; // 중요일정 체크 유무
  DateTime date; // 캘린더에서 뽑아올 시간

  // Constructer

  RecycleModel({
    required this.imagePath,
    required this.workList,
    required this.category,
    required this.check,
    required this.star,
    required this.date,
  });
}
