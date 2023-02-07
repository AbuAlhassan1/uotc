import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optimized_image_loader/optimized_image_loader.dart';
import 'package:video_player/video_player.dart';

class PostController extends GetxController{
  RxList posts = [].obs;
  RxBool isLoading = true.obs;
  RxBool isScrollLoading = false.obs;
  // String videoUrl = "https://player.vimeo.com/progressive_redirect/playback/769576744/rendition/720p/file.mp4?loc=external&oauth2_token_id=57447761&signature=d6f6656f72a88450df65bbd196e74d812bb8d5b5e81f7210a1ca000f9a39c06b";
  // Widget getImage(String imageUrl) {}
  List<String> videosURLs = [
    "https://player.vimeo.com/external/407671488.hd.mp4?s=99cc23f316d3c3fb7067b3b85a66ded697ab7f14&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/551718299.sd.mp4?s=7fac688f051f8fa55660df3d9b14f1943a11651e&profile_id=164&oauth2_token_id=57447761",
    "https://player.vimeo.com/progressive_redirect/playback/734982219/rendition/360p/file.mp4?loc=external&oauth2_token_id=57447761&signature=9a285546ec881a86ca55830637cb41fd85155b092402bed1bbf9ceef16f83971",
    "https://player.vimeo.com/progressive_redirect/playback/769576744/rendition/720p/file.mp4?loc=external&oauth2_token_id=57447761&signature=d6f6656f72a88450df65bbd196e74d812bb8d5b5e81f7210a1ca000f9a39c06b",
    "https://player.vimeo.com/external/490782129.hd.mp4?s=6d2f581ceedbca5ae7c77cbffaac0c70378b7aa1&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/progressive_redirect/playback/734982219/rendition/360p/file.mp4?loc=external&oauth2_token_id=57447761&signature=9a285546ec881a86ca55830637cb41fd85155b092402bed1bbf9ceef16f83971",
    "https://player.vimeo.com/external/554200859.sd.mp4?s=011543f616ce7891c7c2c17babb53e9dc8b88ca5&profile_id=165&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/574429913.hd.mp4?s=9bb0086ad08eae02fe777651eed266f459988f4b&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/403270937.hd.mp4?s=f85dc30881a8ed28d996e8c15179cf9e3d69c75b&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/438908562.sd.mp4?s=84738e3e0b74bb873ee71294fd3779d83ba3df17&profile_id=164&oauth2_token_id=57447761",
  ];
  int index = 0;
  int count = 0;
  Future<VideoPlayerController> getVideo(String videoUrl) async {
    VideoPlayerController videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();
    dev.log("Video Done initializing $count");
    count++;
    return videoController;
  }

  VideoPlayerController getVVideo(String videoUrl) {
    VideoPlayerController videoController = VideoPlayerController.network(videoUrl);
    // await videoController.initialize();
    dev.log("Video Done initializing $count");
    count++;
    return videoController;
  }

  int count2 = 0;
  Future loadInitPosts() async {
    isLoading.value = true;
    for(int i = 0; i < 2; i++){
      posts.add({"video": [await getVideo(videosURLs[index]).timeout(const Duration(seconds: 5))], "type": ["video"]});
      if(index >= 10){
        index = 0;
      }else{
        index++;
      }
      // posts.add({
      //   "data": [
      //     await getVideo(videoUrl),
      //   ],
      //   "type": ["video"]
      // });
      dev.log("Video Added $count2");
      count2++;
    }
    isLoading.value = false;
    dev.log("Init Load Done ...");
  }

  loadPostWithScrollEnd(ScrollController controller) {
    controller.addListener(() async {
      if( !isScrollLoading.value ){
        if( controller.position.atEdge && controller.offset != 0 ){
          isScrollLoading.value = true;
          dev.log("adding post ...");
          posts.add({"video": [await getVideo(videosURLs[index]).timeout(const Duration(seconds: 5))], "type": ["video"]});
          if(index >= 10){
            index = 0;
          }else{
            index++;
          }
          dev.log("post added ...");
          isScrollLoading.value = false;
        }
      }
    });
  }

  // Future<void> loadPosts(ScrollController controller) async {
  //   if( controller.position.atEdge && controller.offset != 0 ){
  //     await Future.delayed(const Duration(seconds: 1), () {
  //       if( posts.length % 2 == 0 ){
  //         posts.add(videoPost);
  //       }else{
  //         posts.add(imagePost);
  //       }
  //     },);
  //   }
  // }
}