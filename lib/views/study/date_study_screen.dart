import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/study/date_study_screen_viewmodel.dart';
import 'package:earlips/views/base/default_back_appbar.dart';
import 'package:earlips/views/study/widget/study_row_card_widget.dart';
import 'package:earlips/views/word/word_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateStudyScreen extends StatelessWidget {
  final DateTime date;

  const DateStudyScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: DateFormat('yyyy/MM/dd').format(date),
        ),
      ),
      body: FutureBuilder<List<LearningSession>>(
        future: DateStudyViewModel(date: date).getSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('no_study_record'.tr),
                  const SizedBox(height: 20),
                  // 학습하러가기
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(ColorSystem.main2),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'go_study'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var session = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 20.0, top: 16.0),
                        child: SmallCard(type: session.type),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30),
                        title: Container(
                          alignment: Alignment.center,
                          child: Text(
                            session.text.length > 13
                                ? '${session.text.substring(0, 13)}...'
                                : session.text,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        onTap: () {
                          Get.to(
                              () => WordScreen(
                                    // session type에 따라 다른 tttle
                                    title: session.type == 0
                                        ? 'row_card_badge_1'.tr
                                        : (session.type == 1
                                            ? 'row_card_badge_2'.tr
                                            : (session.type == 2
                                                ? 'row_card_badge_3'.tr
                                                : 'row_card_badge_4'.tr)),
                                    type: 0,
                                  ),
                              arguments: session.index);
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            );
          }
        },
      ),
    );
  }
}
