import 'package:my_to_do_list/model/recycle_model.dart';
import 'package:my_to_do_list/model/todo_list_model.dart';
import 'package:my_to_do_list/model/important_model.dart';

class Message {
  //Property
  static String workList = ""; // 사용자 입력 일정 초기값
  static String imagePath = ""; // 이미지 주소 초기값
  static String category = ""; // 카테고리 초기값
  static int index = -1; // 일정 수정용 인덱스 정보
  static bool check = false; // 체크박스 초기값
  static bool star = false; // 중요일정 초기값
  static DateTime date = DateTime.now(); // 일정시간 초기값
  static bool action =
      false; // 입력하는 애가 준 것이 true인지 아닌지 판단기준 변수, false일때는 저장되지 않게 거른다.
  static DateTime importantdate = DateTime.now();
  static String profileImagepath = "images/cat.png"; // 프로필 이미지 초기값
  static String profileName = "admin"; // 프로필 이름 초기값
  static String profileEmail = "admin@naver.com"; // 프로필 이메일 초기값
  static String profileDetail = "기본 프로필"; // 프로필 상세 초기값
  static String id = "admin"; // 로그인 계정 아이디
  static String pw = "1234"; // 로그인 계정 패스워드

  static List<RecycleModel> recycleListModel = []; // 휴지통 리스트
  static List<TodoListModel> todoListModel = []; // 전체 리스트
  static List<ImportantModel> importantListModel = []; // 중요일정 리스트
}
