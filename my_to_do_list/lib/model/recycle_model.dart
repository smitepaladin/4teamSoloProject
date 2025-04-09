class RecycleModel {
  //Property


  String recycleimagePath; // 이미지 파일 주소와 파일명
  String recycleworkList; // 사용자 일정 입력값
  String recyclecategory = ""; // 이미지 주소와 같이 붙어가는 카테고리명(ex : 스터디)
  bool recyclecheck; // 체크박스 유무
  bool recyclestar; // 중요일정 체크 유무
  DateTime recycledate; // 캘린더에서 뽑아올 시간



  // Constructer

  RecycleModel(
    {
      required this.recycleimagePath,
      required this.recycleworkList,
      required this.recyclecategory,
      required this.recyclecheck,
      required this.recyclestar,
      required this.recycledate
    }


  );
}