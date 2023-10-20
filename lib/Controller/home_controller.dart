import 'package:firebase_ecom/Model/product_model.dart';
import 'package:firebase_ecom/Service/firebase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Model/brand_model.dart';
import '../Model/carousel_model.dart';
import '../Model/product_category_model.dart';

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

  Future<List<CategoryModel>> fetchAllCategories(BrandModel brand) async {
    try {
      // Implement the logic to fetch categories for the given brand
      // You can use brand.brandName or any other property of BrandModel to identify the brand
      // Example:
      // final categories = await someService.fetchCategoriesForBrand(brand.brandName);
      // return categories;
      return await _firebaseService.fetchCategoriesForBrand(brand.brandName);

    } catch (error) {
      if (kDebugMode) {
        print('Error fetching categories: $error');
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
