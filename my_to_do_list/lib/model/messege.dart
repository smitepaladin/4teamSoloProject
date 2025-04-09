class Message {
  //Property 
  static String workList = ""; // TodolistModel 사용자 입력 일정 초기값
  static String imagePath = ""; // TodolistModel 이미지 주소 초기값
  static String category = ""; // TodolistModel 카테고리 초기값
  static bool check = false; // TodolistModel 체크박스 초기값
  static bool star = false; // TodolistModel 중요일정 초기값
  static DateTime date = DateTime.now(); // TodolistModel 일정시간 초기값
  static String recycleworkList = ""; // RecycleModel 초기값
  static String recycleimagePath = "";
  static String recyclecategory = "";
  static bool recyclecheck = false;
  static bool recyclestar = false;
  static DateTime recycledate = DateTime.now();
  static String importantworkList = ""; // ImportantModel 초기값
  static String importantimagePath = "";
  static String importantcategory = "";
  static bool importantcheck = false;
  static bool importantstar = false;
  static DateTime importantdate = DateTime.now();  
  static String profileImagepath = "images/cat.png"; // 프로필 이미지 초기값
  static String profileName = "admin"; // 프로필 이름 초기값
  static String profileEmail = "admin@naver.com"; // 프로필 이메일 초기값
  static String profileDetail = "기본 프로필"; // 프로필 상세 초기값
  static bool action = false; // 입력하는 애가 준 것이 true인지 아닌지 판단기준 변수, false일때는 저장되지 않게 거른다.
  static String id = "admin"; // 로그인 계정 아이디
  static String pw = "1234"; // 로그인 계정 패스워드
}