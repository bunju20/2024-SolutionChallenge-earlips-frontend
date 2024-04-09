import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/viewModels/realtime/real_create_viewmodel.dart';
import 'package:earlips/views/base/base_screen.dart';


class RealCreateScriptPage extends BaseScreen<RealCreateViewModel> {
  const RealCreateScriptPage({Key? key}) : super(key: key);

  @override
  Widget buildBody(BuildContext context) {
    final RealCreateViewModel speechController = Get.put(RealCreateViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Live Script Title'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 100),
            child: Obx(() => TextField(
              controller: TextEditingController(text: speechController.text.value),
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Voice Recognition',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              textAlignVertical: TextAlignVertical.top,
            )),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => Ink(
                decoration: BoxDecoration(
                  color: speechController.isRecording.value ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () => speechController.toggleRecording(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      speechController.isRecording.value ? Icons.stop : Icons.mic,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
