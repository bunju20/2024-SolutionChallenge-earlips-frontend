import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/phoneme/widget/phoneme_list_widget.dart';
import 'package:earlips/views/phoneme/widget/vowles_widget.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:earlips/views/word/widget/word_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhonemeScreen extends StatelessWidget {
  final String title;
  final int type;

  const PhonemeScreen({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlueBackAppbar(title: title),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Vowels", style: TextStyle(fontSize: 20)),
                  ),
                  VowelsWidget(
                    type: 0,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Consonants", style: TextStyle(fontSize: 20)),
                  ),
                  VowelsWidget(
                    type: 1,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("R-Controlled vowels",
                        style: TextStyle(fontSize: 20)),
                  ),
                  VowelsWidget(
                    type: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
