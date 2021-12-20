import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';

class Carousel extends StatelessWidget {
  Carousel({
    required this.carouselSliderStream,
    required this.isLoadingNextMessages,
  });
  final Stream<List<CarouselSlideModel>> carouselSliderStream;

  final bool isLoadingNextMessages;

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoadingNextMessages ? 1 : 0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late final List<CarouselSlideModel> carouselSlider;
    return StreamBuilder<List<CarouselSlideModel>>(
      stream: carouselSliderStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          carouselSlider = snapshot.data!;

          if (carouselSlider.isNotEmpty) {
            return SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.25,
              //      margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: carouselSlider.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(i.pictureUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return EmptyContent(
              title: "Quelque chose s'est mal passé",
              message: "Impossible de charger les éléments pour le moment",
            );
          }
        }
        return _buildProgressIndicator();
      },
    );
  }
}
