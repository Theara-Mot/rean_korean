
import 'package:flutter_tts/flutter_tts.dart';

class AudioController {
  static final FlutterTts flutterTts = FlutterTts();

  static Future<void> play(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
  static Future<void> playSlow(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setSpeechRate(0.1);
    await flutterTts.speak(text);
  }

  static Future<void> stop() async {
    await flutterTts.stop();
  }
}