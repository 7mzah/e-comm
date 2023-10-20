import 'package:flutter/foundation.dart';
import '../Model/product_category_model.dart';

class AppleProductCategoryProvider with ChangeNotifier {
  List<CategoryModel> _appleProductCategories = [];

  List<CategoryModel> get appleProductCategories => _appleProductCategories;

  void setAppleProductCategories(List<CategoryModel> categories) {
    _appleProductCategories = categories;
    notifyListeners();
  }
}
