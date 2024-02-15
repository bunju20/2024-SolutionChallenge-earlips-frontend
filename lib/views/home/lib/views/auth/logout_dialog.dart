import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('로그아웃'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('정말 로그아웃하시겠습니까?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('취소'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('로그아웃'),
            onPressed: () async {
              // 로그아웃 처리
              // FirebaseAuth.instance.signOut();
              await FirebaseAuth.instance.signOut();
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
