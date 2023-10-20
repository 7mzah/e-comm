import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_ecom/Model/carousel_model.dart';
import 'package:firebase_ecom/providers/carousel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/home_controller.dart';

class NewProductsCarousel extends StatelessWidget {
  const NewProductsCarousel(
      {Key? key, required List<CarouselModel> newCarousel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CarouselProvider>(
      builder: (context, carouselProvider, _) {
        final newCarousel = carouselProvider.carouselImages;

        return Column(
          children: [
            CarouselSlider(
              items: newCarousel.map((carousel) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: FutureBuilder<String>(
                              future:
                                  HomeController().getImageUrl(carousel.image),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // Image loaded, display the actual image
                                  return CachedNetworkImage(
                                      imageUrl: snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return const Text('Error loading image');
                                } else {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
              // Carousel options...

              options: CarouselOptions(
                height: 210,
                initialPage: 0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  carouselProvider.setCurrentSlideIndex(index);
                },
                viewportFraction: 1.0, // Make each item occupy the whole width
              ),
            ),
            Consumer<CarouselProvider>(
              builder: (context, carouselProvider, _) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: newCarousel.map((product) {
                      int index = newCarousel.indexOf(product);
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: carouselProvider.currentSlideIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      );
                    }).toList());
              },
            ),
          ],
        );
      },
    );
  }
}
