import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AuthValidators {
  // Email Validator
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_address'.tr;
    }
    // Email 정규식
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'email_address_input'.tr;
    }
    return null;
  }

  // Password Validator
  // 대충.. 10자리 이상, 문자와 숫자가 섞여있어야 함
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_input'.tr;
    } else if (value.length < 10) {
      return 'password_input_2'.tr;
    } else if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{10,}$')
        .hasMatch(value)) {
      return 'password_input_3'.tr;
    }
    return null;
  }
}
