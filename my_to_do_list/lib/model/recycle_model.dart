class RecycleModel {
  //Property


  String recycleimagePath; // 이미지 파일 주소와 파일명
  String recycleworkList; // 사용자 일정 입력값
  String recyclecategory = "";
  DateTime recycledate; // 캘린더에서 뽑아올 시간



  // Constructer

  RecycleModel(
    {
      required this.recycleimagePath,
      required this.recycleworkList,
      required this.recyclecategory,
      required this.recycledate
    }


  );
}