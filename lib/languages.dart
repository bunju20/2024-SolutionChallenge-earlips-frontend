import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {'title': '제목'},
        'en_US': {'title': 'title'},
        'ja_JP': {'title': '題名'},
        'vi_VN': {'title': 'Tiêu đề'},
      };
}
