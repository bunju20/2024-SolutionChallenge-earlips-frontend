import 'package:earlips/utilities/style/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Function() onTap;

  const AuthCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(label == '구글 계정으로 로그인' ? 15 : 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              SvgPicture.asset(
                iconPath,
                height: label == "구글 계정으로 로그인" ? 30 : 25,
                width: 30,
              ),
              const SizedBox(width: 20),
              Text(label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorSystem.black)),
            ],
          ),
        ),
      ),
    );
  }
}
