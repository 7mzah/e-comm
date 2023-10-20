import 'package:flutter/foundation.dart';

import '../Model/brand_model.dart';
import '../Model/product_category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = []; // Store all the product categories
  List<CategoryModel> get categories => _categories;

  void setCategories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  // Method to get product categories related to a specific brand
  List<CategoryModel> getProductCategoriesForBrand(BrandModel brand) {
    return _categories
        .where((category) => category.brandName == brand.brandName)
        .toList();
  }
}
