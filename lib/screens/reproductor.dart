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
  // Variable para controlar el video actual que se está reproduciendo
  late String currentPlayingVideo;
  // Controlador del video
  VideoController? videoController;

  @override
  void initState() {
    super.initState();
    // Extraemos el videoId de la URL que nos pasa el catalogo
    currentPlayingVideo = _extractVideoId(widget.videoUrl);
  }

  // Función para extraer el videoId de la URL
  String _extractVideoId(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      final queryParams = uri.queryParameters;
      return queryParams['v'] ?? ''; // Retorna el videoId de la URL
    }
    return '';  // Si la URL no es válida, retorna vacío
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reproductor"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Usamos YoutubePlayerEmbed para mostrar el video
          YoutubePlayerEmbed(
            key: ValueKey(currentPlayingVideo), // Usamos el videoId
            callBackVideoController: (controller) {
              videoController = controller;
            },
            videoId: currentPlayingVideo, // Video ID extraído de la URL
            customVideoTitle: "Reproduciendo video", // Título personalizado
            autoPlay: true, // Reproduce el video automáticamente
            hidenVideoControls: false, // Muestra los controles
            mute: false, // No está silenciado
            enabledShareButton: false, // Deshabilita el botón de compartir
            hidenChannelImage: true, // Oculta la imagen del canal
            aspectRatio: 16 / 9, // Relación de aspecto para el video
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
          // Botones para controlar el reproductor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await videoController?.playVideo(); // Reproducir el video
                },
                child: const Text("Play"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  await videoController?.pauseVideo(); // Pausar el video
                },
                child: const Text("Pause"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  await videoController?.muteOrUnmuteVideo(); // Silenciar/activar sonido
                },
                child: const Text("Mute/Unmute"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
