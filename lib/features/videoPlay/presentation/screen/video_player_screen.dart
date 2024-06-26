import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String movieId;
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.movieId
  });
  static const String routeName = '/videoPlayer';

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _showPlayPauseButton = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _toggleButtonVisibility() {
    setState(() {
      _showPlayPauseButton = !_showPlayPauseButton;
    });
    if (_showPlayPauseButton) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _showPlayPauseButton = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A071E),
      body: SafeArea(
        child: GestureDetector(
                      onTap: _toggleButtonVisibility,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                          ),
                          if (_showPlayPauseButton)
                            Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: IconButton(
                                  iconSize: 64.0,
                                  icon: Icon(
                                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  onPressed: _togglePlayPause,
                                ),
                              ),
                            ),
                          if (_controller.value.isInitialized)
                            Positioned(
                              bottom: 40,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,

                                  colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    bufferedColor: Colors.grey,
                                    backgroundColor: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                )
    );
  }
}
