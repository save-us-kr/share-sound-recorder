import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logger_plus/flutter_logger_plus.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;

void main() {
  runApp(const MaterialApp(home: Audio()));
}

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<StatefulWidget> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatTime(Duration duration) {
    logger.info("formatTime duration: $duration");

    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String result = '$minutes:${seconds.toString().padLeft(2, '0')}';

    logger.info("formatTime result: $result");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          '녹음',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                SliderTheme(
                  data: const SliderThemeData(
                    inactiveTrackColor: Colors.grey,
                  ),
                  child: Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      setState(() {
                        position = Duration(seconds: value.toInt());
                      });
                      await audioPlayer.seek(position);
                    },
                    activeColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(position),
                        style: const TextStyle(color: Colors.brown),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.transparent,
                        child: IconButton(
                          padding: const EdgeInsets.only(bottom: 50),
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.brown,
                          ),
                          iconSize: 25,
                          onPressed: () async {
                            logger.info("isplaying 전 : $isPlaying");

                            if (isPlaying) {
                              //재생중이면
                              await audioPlayer.pause(); //멈춤고
                              setState(() {
                                isPlaying = false; //상태변경하기..?
                              });
                            } else {
                              //멈춘 상태였으면
                              //  await playAudio();
                              await audioPlayer.resume(); // 녹음된 오디오 재생
                            }
                            logger.info("isplaying 후 : $isPlaying");
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        formatTime(duration),
                        style: const TextStyle(color: Colors.brown),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            child: IconButton(
              onPressed: () async {
                if (recorder.isRecording) {
                  // await stop();
                } else {
                  // await record();
                }
                setState(() {});
              },
              icon: Icon(
                recorder.isRecording ? Icons.stop : Icons.mic,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isPlaying = false;
  bool isRecording = false;

  String audioPath = '';
  String playAudioPath = '';

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final audioPlayer = AudioPlayer();
  final recorder = sound.FlutterSoundRecorder();
}
