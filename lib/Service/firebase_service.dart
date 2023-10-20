import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ecom/Model/product_model.dart';
import 'package:flutter/foundation.dart';

import '../Model/brand_model.dart';
import '../Model/carousel_model.dart';
import '../Model/product_category_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _productsCollection = 'deviceDetails';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(_productsCollection).get();
      List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel(
          phoneName: doc['phoneName'],
          brandName: doc['brandName'],
          color: doc['color'],
          price: doc['price'].toDouble(),
          image: doc['image'],
          storage: doc['storage'].toDouble(),
        );
      }).toList();
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
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('Brands').get();

      final List<BrandModel> brands = snapshot.docs.map((doc) {
        final data = doc.data();
        return BrandModel(
          brandName: data['BrandName'],
          brandImage: data['BrandImage'],
        );
      }).toList();

      return brands;
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error fetching brands: $error');
      }
      return [];
    }
  }

  Future<List<CarouselModel>> getCarouselImages() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("NewCollection").get();
      List<CarouselModel> carouselImages = snapshot.docs.map((doc) {
        return CarouselModel(image: doc.data()['Image']);
      }).toList();
      return carouselImages;
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Failed to fetch carousel images: $error');
      }
      return [];
    }
  }

  Future<List<CategoryModel>> fetchCategoriesForBrand(String brand) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('Categories')
          .where('brandName', isEqualTo: brand)
          .get();

      final List<CategoryModel> categories = snapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel(
          categoryName: data['categoryName'],
          imageUrl: data['imageUrl'],
          brandName: data['brandName'],
        );
      }).toList();

      return categories;
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error fetching categories: $error');
      }
      return [];
    }
  }
}
