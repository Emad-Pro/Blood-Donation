import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<int> {
  VideoCubit() : super(0);

  final List<String> videoPaths = [
    'assets/video/video1.mp4',
    'assets/video/video2.mp4',
    'assets/video/video3.mp4',
    'assets/video/video1.mp4',
  ];

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  CarouselSliderController? _carouselController;

  ChewieController? get chewieController => _chewieController;

  void setCarouselController(CarouselSliderController controller) {
    _carouselController = controller;
  }

  void initializeVideo(int index) {
    _videoPlayerController = VideoPlayerController.asset(videoPaths[index])
      ..initialize().then((_) {
        _chewieController = ChewieController(
          aspectRatio: 16 / 9,
          videoPlayerController: _videoPlayerController,
          autoPlay: false,
          looping: false,
        );
        _videoPlayerController.addListener(_checkVideoEnd);
        emit(index);
      });
  }

  void _checkVideoEnd() {
    if (_videoPlayerController.value.position >=
        _videoPlayerController.value.duration) {
      _carouselController?.nextPage();
    }
  }

  void dispose() {
    _videoPlayerController.removeListener(_checkVideoEnd);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
  }
}
