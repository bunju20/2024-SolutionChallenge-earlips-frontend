import 'package:get/get.dart';
import 'package:earlips/viewModels/home/home_viewmodel.dart';
import 'package:earlips/viewModels/root/root_viewmodel.dart';
import 'package:earlips/viewModels/study/study_viewmodel.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());

    // ChildViewModel is singleton
    Get.put(HomeViewModel());
    Get.put(StudyViewModel());
  }
}
