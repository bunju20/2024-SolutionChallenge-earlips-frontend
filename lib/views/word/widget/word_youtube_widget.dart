import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeWordPlayer extends StatefulWidget {
  const YoutubeWordPlayer({super.key});

  @override
  State<YoutubeWordPlayer> createState() => _YoutubeWordPlayerState();
}

class _YoutubeWordPlayerState extends State<YoutubeWordPlayer> {
  final WordViewModel wordViewModel = Get.find<WordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (wordViewModel.wordList.isEmpty) {
        if (wordViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('no_data'.tr));
        }
      } else {
        final videoId = wordViewModel
            .wordList[wordViewModel.currentIndex.value].wordCard.video;
        return YoutubePlayer(
          key: ValueKey(
              videoId), // Ensure the player is rebuilt when the video changes
          controller: YoutubePlayerController(initialVideoId: videoId),
        );
      }
    });
  }
}
