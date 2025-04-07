import 'package:get/get.dart';
import 'package:my_to_do_list/model/recycle_model.dart';

class RecycleBinController extends GetxController {
  var recycleListModel = <RecycleModel>[].obs;

  // 데이터 추가
  void addToRecycleBin(RecycleModel recycle) {
    recycleListModel.add(recycle);
  }

  // 데이터 삭제
  void removeFromRecycleBin(RecycleModel recycle) {
    recycleListModel.remove(recycle);
  }
}