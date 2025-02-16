import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cubit/video_player_cubit.dart';

class VideoCarouselScreen extends StatefulWidget {
  @override
  _VideoCarouselScreenState createState() => _VideoCarouselScreenState();
}

class _VideoCarouselScreenState extends State<VideoCarouselScreen> {
  late VideoCubit videoCubit;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    videoCubit = VideoCubit();
    videoCubit.initializeVideo(0);
  }

  @override
  void dispose() {
    videoCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, int>(
      bloc: videoCubit,
      builder: (context, currentIndex) {
        return videoCubit.chewieController == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: videoCubit.videoPaths.length,
                      options: CarouselOptions(
                        viewportFraction: 1,
                        aspectRatio: 1 / 1,
                        height: 400,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          videoCubit.initializeVideo(index);
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          // width: double.infinity,
                          child: videoCubit.chewieController!
                                      .videoPlayerController.dataSource ==
                                  videoCubit.videoPaths[index]
                              ? Chewie(controller: videoCubit.chewieController!)
                              : Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: videoCubit.state > 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: !(videoCubit.state > 0)
                            ? null
                            : () {
                                _carouselController.previousPage();
                              },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: videoCubit.state <
                                  videoCubit.videoPaths.length - 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: !(videoCubit.state <
                                videoCubit.videoPaths.length - 1)
                            ? null
                            : () {
                                _carouselController.nextPage();
                              },
                      ),
                    ],
                  )
                ],
              );
      },
    );
  }
}
