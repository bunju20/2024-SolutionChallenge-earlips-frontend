import 'package:earlips/views/base/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:earlips/viewModels/study/study_viewmodel.dart';
import 'package:earlips/views/study/widget/contribution.dart';
import '../realtime/real_create_script_screen.dart';


class StudyMain extends BaseScreen<StudyViewModel> {
  const StudyMain({super.key});
  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //뒤로가기 화살표 없애기
          automaticallyImplyLeading: false,
          title: Container(
              alignment: Alignment.center,
              child: Text('학습페이지')),
        ),
        body: Column(
          children: [
            Container(
              child: Container(
                color: Color(0xFF),
                child: Contribute(),
                // child: ContributionWidget(),
              ),
            ),
            Container(

                child: Column(

                    children:[
                      Row(
                        children: [
                          _Card(
                            title: "음소 교정",
                            subtitle: "옴소 교정 및 발음 테스트",
                            imagePath: "assets/images/study/one.svg",
                            onTap: (){
                              Get.to(() => RealCreateScriptPage());
                            },
                          ),
                          _Card(
                            title: "단어 교정",
                            subtitle: "단어 교정 및 발음 테스트",
                            imagePath: "assets/images/study/2.svg",
                            onTap: (){
                              Get.to(() => RealCreateScriptPage());
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _Card(
                            title: "문장 교정",
                            subtitle: "문장 교정 및 발음 테스트",
                            imagePath: "assets/images/study/one.svg",
                            onTap: (){
                              Get.to(() => RealCreateScriptPage());
                            },
                          ),
                          _Card(
                            title: "문단 교정",
                            subtitle: "대본 입력 및 발음 테스트",
                            imagePath: "assets/images/study/one.svg",
                            onTap: (){
                              Get.to(() => RealCreateScriptPage());
                            },
                          ),
                        ],
                      ),
                    ]
                )
            )
          ],
        )
    );
  }
  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => true;
}


class _Card extends BaseWidget<StudyViewModel> {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;
  const _Card({super.key,required this.title, required this.subtitle, required this.imagePath, required this.onTap});

  @override
  Widget buildView(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => onTap());
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.0,top: 20.0),
        height: Get.height * 0.21,
        width: Get.width * 0.43,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: SvgPicture.asset(
                'assets/images/study/3.svg',
                width: 85,
                height: 85,
              ),
              width: 90,
              height: 90,
            ),
            Text(title,
              style: TextStyle(
                fontFamily: 'Pretendard-Bold',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Pretendard-Regular',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
