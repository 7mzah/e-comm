import 'package:flutter/foundation.dart';
import '../Model/brand_model.dart';

class BrandProvider with ChangeNotifier {
  List<BrandModel> _brands = [];

  List<BrandModel> get brands => _brands;

  void setBrands(List<BrandModel> brands) {
    _brands = brands;
    notifyListeners();
  }
}
