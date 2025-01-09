import 'package:flutter/material.dart';
import 'package:youtube_player_embed/controller/video_controller.dart';
import 'package:youtube_player_embed/enum/video_state.dart';
import 'package:youtube_player_embed/youtube_player_embed.dart';

class Reproductor extends StatefulWidget {
  final String videoUrl;

  const Reproductor({super.key, required this.videoUrl});

  @override
  _ReproductorState createState() => _ReproductorState();
}

class _ReproductorState extends State<Reproductor> {
  late String currentPlayingVideo;
  VideoController? videoController;

  @override
  void initState() {
    super.initState();
    currentPlayingVideo = _extractVideoId(widget.videoUrl);
  }

  String _extractVideoId(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      final queryParams = uri.queryParameters;
      return queryParams['v'] ?? '';
    }
    return ''; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Reproductor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Usamos YoutubePlayerEmbed para mostrar el video
            YoutubePlayerEmbed(
              key: ValueKey(currentPlayingVideo),
              callBackVideoController: (controller) {
                videoController = controller;
              },
              videoId: currentPlayingVideo,
              customVideoTitle: "Reproduciendo video",
              autoPlay: true,
              hidenVideoControls: false,
              mute: false,
              enabledShareButton: false,
              hidenChannelImage: true,
              aspectRatio: 16 / 9,
              onVideoEnd: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Video terminado!')),
                );
              },
              onVideoStateChange: (state) {
                switch (state) {
                  case VideoState.playing:
                    print("Video está en reproducción");
                    break;
                  case VideoState.paused:
                    print("Video pausado");
                    break;
                  case VideoState.muted:
                    print("Video silenciado");
                    break;
                  case VideoState.unmuted:
                    print("Video desilenciado");
                    break;
                  case VideoState.fullscreen:
                    print("Video en pantalla completa");
                    break;
                  case VideoState.normalView:
                    print("Video en vista normal");
                    break;
                }
              },
            ),
            const SizedBox(height: 20),
            // Controles del reproductor
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton("Play", Colors.teal, () async {
                  await videoController?.playVideo();
                }),
                const SizedBox(width: 20),
                _buildControlButton("Pause", Colors.orange, () async {
                  await videoController?.pauseVideo();
                }),
                const SizedBox(width: 20),
                _buildControlButton("Mute/Unmute", Colors.red, () async {
                  await videoController?.muteOrUnmuteVideo();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildControlButton(String text, Color color, Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Color personalizado para cada botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 4,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
