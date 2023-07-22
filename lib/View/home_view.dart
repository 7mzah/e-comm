import 'package:firebase_ecom/View/pages/cart_page.dart';
import 'package:firebase_ecom/View/pages/shop_page.dart';
import 'package:firebase_ecom/providers/carousel_provider.dart';
import 'package:firebase_ecom/widgets/homeView/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ecom/Model/product_model.dart';
import 'package:firebase_ecom/Controller/home_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Model/brand_model.dart';
import '../Model/carousel_model.dart';
import '../providers/brand_provider.dart';
import '../providers/product_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  final HomeController _homeController = HomeController();
  List<ProductModel>? _products;
  bool _isProductsFetched = false;
  List<BrandModel>? _brands;
  bool _isBrandsFetched = false;
  List<CarouselModel>? _carousels;
  bool _isCarouselFetched = false;

  @override
  void initState() {
    super.initState();
    _products = [];
    _brands = [];
    _carousels = [];
    _fetchData();
  }

  Future<void> _fetchData() async {
    final productProvider = Provider.of<ProductProvider>(
        context, listen: false);
    final brandProvider = Provider.of<BrandProvider>(context, listen: false);
    final carouselProvider = Provider.of<CarouselProvider>(
        context, listen: false);
    if (!_isProductsFetched) {
      _isProductsFetched = true;
      _products = await _homeController.fetchProducts();
      productProvider.setProducts(_products!);
    }

    if (!_isBrandsFetched) {
      _isBrandsFetched = true;
      _brands = await _homeController.fetchBrands();
      brandProvider.setBrands(_brands!);
    }
    if(!_isCarouselFetched){
      _isCarouselFetched = true;
      _carousels = await _homeController.fetchCarousel();
      carouselProvider.setCarousel(_carousels!);
    }
  }

  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: HomeNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),


      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          children: [
            DrawerHeader(
              child: SvgPicture.asset("assets/bitmap.svg"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(color: Colors.grey[800],),
            ),
          ],
        ),
      ),
      body: _products != null && _brands != null
          ? _buildPage()
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildPage() {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;
    final brandProvider = Provider.of<BrandProvider>(context);
    final brands = brandProvider.brands;
    final carouselProvider = Provider.of<CarouselProvider>(context);
    final carousel = carouselProvider.carouselImages;

    return IndexedStack(
      index: _selectedIndex,
      children: [
        if (products != null && brands != null && carousel != null) ShopPage(
            products: products, brands: brands, carousel: carousel),
        const CartPage(),
      ],
    );
  }

}
