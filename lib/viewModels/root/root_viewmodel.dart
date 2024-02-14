import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:earlips/utilities/app_routes.dart';
class RootViewModel extends GetxController {
  late final RxInt _selectedIndex;

  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();

    _selectedIndex = 0.obs;
  }

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  void onTapBed() {
    Get.toNamed(Routes.HOME);
  }

}
