part of '../share_sound_recorder.dart';

class ShareAudioPlayer {
  static Duration duration = Duration.zero;
  static Duration position = Duration.zero;

  static final recorder = sound.FlutterSoundRecorder();

  static bool isRecording = false;

  static String audioPath = '';
  static String playAudioPath = '';

  static final audioPlayer = AudioPlayer();

  static bool isPlaying = false;
}
