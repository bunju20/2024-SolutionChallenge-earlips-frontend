class AuthValidators {
  // Email Validator
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일 주소를 입력해주세요';
    }
    // Email 정규식
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return '올바른 이메일 주소를 입력해주세요';
    }
    return null;
  }

  // Password Validator
  // 대충.. 10자리 이상, 문자와 숫자가 섞여있어야 함
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else if (value.length < 10) {
      return '비밀번호는 10자리 이상이어야 합니다';
    } else if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{10,}$')
        .hasMatch(value)) {
      return '비밀번호는 문자와 숫자가 섞여있어야 합니다';
    }
    return null;
  }
}
