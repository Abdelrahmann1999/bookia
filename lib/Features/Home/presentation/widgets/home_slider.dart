import 'package:bookia/Features/Home/data/model/slider_response/slider.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class homeSlider extends StatefulWidget {
  const homeSlider({super.key, required this.sliders});

  final List<SliderModel> sliders;

  @override
  State<homeSlider> createState() => _homeSliderState();
}

class _homeSliderState extends State<homeSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeletonizer(
          enabled: widget.sliders.isEmpty,
          child: CarouselSlider.builder(
            itemCount: widget.sliders.isEmpty ? 1 : widget.sliders.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
                  if (widget.sliders.isEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    );
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.sliders[itemIndex].image ?? "",
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),

                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.9,
              reverse: false,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
        ),
        Gap(15),
        SmoothPageIndicator(
          controller: PageController(initialPage: activeIndex),
          count: widget.sliders.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.primary,
            dotColor: AppColors.border,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
            expansionFactor: 4,
          ),
          onDotClicked: (index) {},
        ),
      ],
    );
  }
}
