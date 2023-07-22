import 'package:flutter/material.dart';
import 'package:firebase_ecom/Model/product_model.dart';
import 'package:firebase_ecom/Controller/home_controller.dart';

class ProductProvider extends ChangeNotifier {
  final HomeController _homeController = HomeController();
  List<ProductModel>? _products;

  List<ProductModel>? get products => _products;

  Future<void> fetchProducts() async {
    _products = await _homeController.fetchProducts();
    notifyListeners();
  }

  void setProducts(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  int _currentSlideIndex = 0;

  int get currentSlideIndex => _currentSlideIndex;

  void setCurrentSlideIndex(int index) {
    _currentSlideIndex = index;
    notifyListeners();
  }
}
