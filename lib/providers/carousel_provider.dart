import 'package:firebase_ecom/Controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_ecom/Model/carousel_model.dart';
import 'package:firebase_ecom/Service/firebase_service.dart';

class CarouselProvider with ChangeNotifier {
  final HomeController _homeController = HomeController();
  List<CarouselModel> _carouselImages = [];

  List<CarouselModel> get carouselImages => _carouselImages;

  void setCarousel(List<CarouselModel> carouselImage) {
    _carouselImages = carouselImage;
    notifyListeners();
  }

  Future<void> fetchCarouselImages() async {
    try {
      _carouselImages = await _homeController.fetchCarousel();
      notifyListeners();
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Failed to fetch carousel images: $error');
      }
    }
  }

  int _currentSlideIndex = 0;

  int get currentSlideIndex => _currentSlideIndex;

  void setCurrentSlideIndex(int index) {
    _currentSlideIndex = index;
    notifyListeners();
  }
}
