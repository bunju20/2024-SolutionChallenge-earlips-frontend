import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:get/get.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserViewModel>(() => UserViewModel());
  }
}
