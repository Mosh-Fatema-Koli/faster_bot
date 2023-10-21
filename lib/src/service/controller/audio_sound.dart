import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;

  Future<void> playAudio() async {
    if (isPlaying.value){
   //   await audioPlayer.pause();
    } else {
      isPlaying.value=true;
      await audioPlayer.play(AssetSource('audio/notifications-sound.mp3'),);
      await Future.delayed(const Duration(seconds:1)); // Play for 2 seconds
      await audioPlayer.pause();
    }
    isPlaying.value = false;
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
