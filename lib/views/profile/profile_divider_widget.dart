import 'package:flutter/material.dart';

class ProfileDividerWidget extends StatelessWidget {
  const ProfileDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // width 꽉 차게
        width: double.infinity,
        height: 8,
        decoration: const BoxDecoration(color: Color(0xffe9e9ee)));
  }
}
