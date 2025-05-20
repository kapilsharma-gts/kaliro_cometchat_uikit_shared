import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../kaliro_cometchat_uikit_shared.dart';

///Gives Full screen video player for [CometChatVideoBubble]
class VideoPlayer extends StatefulWidget {
  const VideoPlayer(
      {super.key,
      required this.videoUrl,
      this.playPauseIcon,
      this.backIcon,
      this.fullScreenBackground});

  final String videoUrl;

  final Icon? playPauseIcon;

  final Color? backIcon;

  final Color? fullScreenBackground;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  initializeVideo() async {
    try {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await _controller!.initialize();
      _chewieController = ChewieController(
          videoPlayerController: _controller!,
          showOptions: false,
          materialProgressColors: ChewieProgressColors(
            backgroundColor:
                widget.fullScreenBackground ?? const Color(0xffFFFFFF),
            playedColor: widget.backIcon ?? const Color(0xff3399FF),
          ));
      setState(() {});
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor:
              widget.fullScreenBackground ?? const Color(0xffFFFFFF),
          body: Center(
            child: Stack(
              children: [
                _controller == null || !_controller!.value.isInitialized
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        AssetConstants.back,
                        package: UIConstants.packageName,
                        color: widget.backIcon ?? const Color(0xff3399FF),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}

class Abc extends StatefulWidget {
  const Abc({super.key});

  @override
  State<Abc> createState() => _AbcState();
}

class _AbcState extends State<Abc> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
