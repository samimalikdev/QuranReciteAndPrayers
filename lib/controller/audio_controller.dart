import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController {
  var isLoading = false.obs;
  var isPlaying = false.obs;
  var playingIndex = (-1).obs; 
  var playingIndex1 = (-1).obs; 
  var stopRequested = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    audioPlayer.onPlayerComplete.listen((event) {
      playingIndex.value = -1;

      if (!stopRequested.value) {
        playingIndex1.value = -1;
        isPlaying.value = false;
      }
    });
  }

  Future<void> playAudio(int ayahNumber, int index) async {
    isLoading.value = true;
    playingIndex.value = index;

    final audioUrl =
        "https://cdn.islamic.network/quran/audio/128/ar.alafasy/$ayahNumber.mp3";

    try {
      await audioPlayer.play(UrlSource(audioUrl));
      print("playing audio url: $audioUrl");
    } catch (e) {
      print("Error playing audio: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> playAllAudio(int ayahNumber, int index) async {
    stopRequested.value = false;
    isPlaying.value = true;
    playingIndex1.value = index;

    final audioUrl =
        "https://cdn.islamic.network/quran/audio/128/ar.alafasy/$ayahNumber.mp3";

    try {
      await audioPlayer.play(UrlSource(audioUrl));
      print("playing audio all sajjsajasjsaj url: $audioUrl");
      isPlaying.value = false;

      audioPlayer.onPlayerComplete.listen((event) {
        if (playingIndex1.value == index) {
          isPlaying.value = false;
          playingIndex1.value = -1;
        }

        if (stopRequested.value) {
          isPlaying.value = false;
          playingIndex1.value = -1;
        }
      });
    } catch (e) {
      print("Error playing audio: $e");
      isPlaying.value = false;
    }
  }

  Future<void> surahAudio(int surahNumber) async {
    isPlaying.value = true;
    final audioUrl =
        "https://cdn.islamic.network/quran/audio/128/ar.alafasy/$surahNumber.mp3";

    try {
      await audioPlayer.play(UrlSource(audioUrl));
      print("playing audio url: $audioUrl");
    } catch (e) {
      print("Error playing audio: $e");
    } finally {
      isPlaying.value = false;
    }
  }

  void stopAudio() {
    audioPlayer.stop();
    playingIndex.value = -1;
    playingIndex1.value = -1;
    isPlaying.value = false;
    stopRequested.value = true;

    Future.delayed(const Duration(seconds: 5), () {
      stopRequested.value = false;
      isPlaying.value = false;
    });
  }
}
