import 'package:flutter/material.dart';

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
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('로그아웃'),
            onPressed: () {
              // 로그아웃 처리
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
