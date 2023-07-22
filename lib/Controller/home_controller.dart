import 'package:firebase_ecom/Model/product_model.dart';
import 'package:firebase_ecom/Service/firebase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Model/brand_model.dart';
import '../Model/carousel_model.dart';

class HomeController {
  final FirebaseService _firebaseService = FirebaseService();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      // Call the Firebase service to fetch the products
      List<ProductModel> products = await _firebaseService.fetchProducts();
      return products;
    } catch (e) {
      // Handle any errors that occur during fetching
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
      return [];
    }
  }

  Future<List<BrandModel>> fetchBrands() async {
    try {
      List<BrandModel> brands = await _firebaseService.fetchBrands();
      return brands;
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error fetching brands: $error');
      }
      return [];
    }
  }

  Future<List<CarouselModel>> fetchCarousel() async {
    try {
      List<CarouselModel> carousels = await _firebaseService.getCarouselImages();
      return carousels;
    }
    catch(error){
      if(kDebugMode){
        print('Error fetching carousel: $error');
      }
      return [];
    }
  }

  Future<String> getImageUrl(String imagePath) async {
    final firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.refFromURL(imagePath);
    final String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
}
