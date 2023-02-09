import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PostController extends GetxController{
  RxList posts = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxBool isScrollLoading = false.obs;
  static List<String> videosURLs = [
    "https://player.vimeo.com/external/551718299.sd.mp4?s=7fac688f051f8fa55660df3d9b14f1943a11651e&profile_id=164&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/551718299.sd.mp4?s=7fac688f051f8fa55660df3d9b14f1943a11651e&profile_id=164&oauth2_token_id=57447761",
    "https://player.vimeo.com/progressive_redirect/playback/734982219/rendition/360p/file.mp4?loc=external&oauth2_token_id=57447761&signature=9a285546ec881a86ca55830637cb41fd85155b092402bed1bbf9ceef16f83971",
    "https://player.vimeo.com/progressive_redirect/playback/769576744/rendition/720p/file.mp4?loc=external&oauth2_token_id=57447761&signature=d6f6656f72a88450df65bbd196e74d812bb8d5b5e81f7210a1ca000f9a39c06b",
    "https://player.vimeo.com/external/490782129.hd.mp4?s=6d2f581ceedbca5ae7c77cbffaac0c70378b7aa1&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/progressive_redirect/playback/734982219/rendition/360p/file.mp4?loc=external&oauth2_token_id=57447761&signature=9a285546ec881a86ca55830637cb41fd85155b092402bed1bbf9ceef16f83971",
    "https://player.vimeo.com/external/554200859.sd.mp4?s=011543f616ce7891c7c2c17babb53e9dc8b88ca5&profile_id=165&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/574429913.hd.mp4?s=9bb0086ad08eae02fe777651eed266f459988f4b&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/403270937.hd.mp4?s=f85dc30881a8ed28d996e8c15179cf9e3d69c75b&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/438908562.sd.mp4?s=84738e3e0b74bb873ee71294fd3779d83ba3df17&profile_id=164&oauth2_token_id=57447761",
    "https://vod-progressive.akamaized.net/exp=1675790951~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1240%2F20%2F506203139%2F2321496974.mp4~hmac=77a8051fb6cf91cb626b0aa71238bb4a4f30c3dd1a6180eb2e5fd8a8e0e6522d/vimeo-prod-skyfire-std-us/01/1240/20/506203139/2321496974.mp4",
    "https://player.vimeo.com/progressive_redirect/playback/750511030/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=5d7d57c15f2d464aa62d565a699112b7d96740cf759cb6038d45fa92a5ccd4ca",
    "https://player.vimeo.com/external/558993769.hd.mp4?s=2ff1ff405548b4431a531398af5eb8725f345d00&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/541884708.hd.mp4?s=4fac0aceee4b8e59616d71f5781b0a5151789c5a&profile_id=174&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/559861487.sd.mp4?s=cbabf6a797af3debad35563de8cad4dad577d56d&profile_id=165&oauth2_token_id=57447761",
    "https://player.vimeo.com/external/651066537.hd.mp4?s=e44515f95c28f9f84414e8117a20f598098f42bf&profile_id=174&oauth_token_id=57447761",
    "https://player.vimeo.com/progressive_redirect/playback/709838594/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=89b8c7afdb9c548b1dd98421915d41ede293846e2a98d45ece810de234e95846",
    "https://player.vimeo.com/progressive_redirect/playback/747386580/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=3ca2977a26fcfda01a9c686589e79c015ecdd2a6c4edb296180f4de61af9d9ee",
    "https://player.vimeo.com/external/515035289.sd.mp4?s=22eb8452ea6692a819752c114d5c355f27af3b27&profile_id=165&oauth2_token_id=57447761",
    "https://player.vimeo.com/progressive_redirect/playback/723688128/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=fc6c75b0da793efb1a97c087aee465ac7d9d83604d41f7b1e9348c13d487906c"
  ];
  int index = 0;
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    loadInitPosts();
  }

  Future<ChewieController?> getVideo(String videoSource) async {
    final VideoPlayerController videoController;
    final ChewieController chewieController;

    // Trying To Initializing The VideoController -- S t a r t --
    try{
      videoController = VideoPlayerController.network(
        "https://player.vimeo.com/progressive_redirect/playback/784449954/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=11d28733eb7e8fa61fc6a8ecacfc35e03ec3c1a972bcc66fd2ce1964d773e648"
      );
      await videoController.initialize();
    }
    // Trying To Initializing The VideoController -- E n d --

    // If The Initialization Failed Return Null -- S t a r t --
    catch( error ){
      dev.log(error.toString());
      print(error.toString());
      return null;
    }
    // If The Initialization Failed Return Null -- E n d --

    // If The Initialization Run Seccessfully -- S t a r t --
    try{
      chewieController = ChewieController(
        videoPlayerController: videoController,
        allowFullScreen: false,
        allowMuting: true,
        autoPlay: true,
      );
    }
    catch( error ){
      dev.log(error.toString());
      print(error.toString());
      return null;
    }
    index++;
    return chewieController;
    // If The Initialization Run Seccessfully -- E n d --
  }

  int count2 = 0;
  Future loadInitPosts() async {
    isLoading.value = true;
    for(int i = 0; i < 2; i++){
      ChewieController? video = await getVideo(videosURLs[index]);
      if(video != null){
        posts.add({ "video": [video], "type": ["video"] });
        index++;
        print("Video Added $count2");
        count2++;
      }else{
        print("Something went wrong");
      }
    }
    isLoading.value = false;
    print("Init Load Done ...");
  }

  loadPostWithScrollEnd(ScrollController controller) {
    controller.addListener(() async {
      print("whaaaaaaaaaaaaaaaaaaaaaaaaat");
      if( !isScrollLoading.value ){
        print("whaaaaaaaaaaaaaaaaaaaaaaaaat  222222222222222");
        if( controller.offset >= controller.positions.last.pixels - 100.h ){
          
          isScrollLoading.value = true;

          print("adding post ...");

          ChewieController? video = await getVideo(videosURLs[index])
          .timeout(const Duration(seconds: 5), onTimeout: () async {
            print("asdasdasd");
            return null;
          });

          if(video != null){
            posts.add({ "video": [video], "type": ["video"] });
            if( index == 19 ){ index = 0;}
            else{ index++; }
            print("Video Added $count2");
            count2++;
            isScrollLoading.value = false;
          }
          else{
            isScrollLoading.value = false;
            print("Something Went Wrong !!!!!!!!!");
          }
        }
      }
    });
  }
}