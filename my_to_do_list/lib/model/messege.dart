class Message {
  //Property 생성자가 없다 프로퍼티만 있다
  static String workList = ""; // 데이터를 계속 가지고 있는 프로퍼티
  static String imagePath = "";
  static String category = "";
  static bool check = false;
  static bool star = false;
  static DateTime date = DateTime.now();
  static String recycleworkList = ""; // 데이터를 계속 가지고 있는 프로퍼티
  static String recycleimagePath = "";
  static String recyclecategory = "";
  static bool recyclecheck = false;
  static bool recyclestar = false;
  static DateTime recycledate = DateTime.now();
  static String importantworkList = ""; // 데이터를 계속 가지고 있는 프로퍼티
  static String importantimagePath = "";
  static String importantcategory = "";
  static bool importantcheck = false;
  static bool importantstar = false;
  static DateTime importantdate = DateTime.now();  
  static String profileImagepath = "images/avatar.jpg";
  static String profileName = "admin";
  static String profileEmail = "admin@naver.com";
  static String profileDetail = "기본 프로필";
  static bool action = false; // 입력하는 애가 준 것이 true인지 아닌지 판단기준 변수, false일때는 저장되지 않게 거른다.
  static String id = "admin";
  static String pw = "1234";
}