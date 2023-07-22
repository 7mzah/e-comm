import 'package:firebase_ecom/Model/brand_model.dart';
import 'package:firebase_ecom/Model/carousel_model.dart';
import 'package:firebase_ecom/providers/brand_provider.dart';
import 'package:firebase_ecom/widgets/shoppage/brandTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/product_model.dart';
import '../../providers/carousel_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/shoppage/new_products_carousel.dart';
import '../../widgets/shoppage/productTile.dart';

class ShopPage extends StatefulWidget {
  final List<ProductModel> products;

  const ShopPage(
      {Key? key, required this.products, required List<BrandModel> brands, required List<CarouselModel> carousel})
      : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<ProductModel> _filteredProducts = [];
  late List<BrandModel> _brands;
  late List<CarouselModel> _carousel;
  final TextEditingController _searchController = TextEditingController();
  bool _showClearIcon = false; // Variable to control clear icon visibility

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.products;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts(String query) {
    setState(() {
      _showClearIcon = query.isNotEmpty; // Update the clear icon visibility
      _filteredProducts = widget.products
          .where((product) =>
              product.brandName.toLowerCase().contains(query.toLowerCase()) ||
              product.phoneName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ProductProvider, BrandProvider, CarouselProvider>(
      builder: (context, productProvider, brandProvider, carouselProvider, _) {
        final List<CarouselModel> carousels = carouselProvider.carouselImages;
        final List<ProductModel>? products = productProvider.products;
        _brands = brandProvider.brands;
        final bool showCarousel = _searchController.text.isEmpty;

        // Sort the brands list
        _brands.sort((a, b) {
          if (a.brandName == 'Apple') {
            return -1; // 'Apple' comes before 'b'
          } else if (b.brandName == 'Apple') {
            return 1; // 'b' comes before 'Apple'
          } else if (a.brandName == 'Samsung') {
            return -1; // 'Samsung' comes before 'b'
          } else if (b.brandName == 'Samsung') {
            return 1; // 'b' comes before 'Samsung'
          } else if (a.brandName == 'Huawei') {
            return -1; // 'Huawei' comes before 'b'
          } else if (b.brandName == 'Huawei') {
            return 1; // 'b' comes before 'Huawei'
          } else if (a.brandName == 'Xiaomi') {
            return -1; // 'Xiaomi' comes before 'b'
          } else if (b.brandName == 'Xiaomi') {
            return 1; // 'b' comes before 'Xiaomi'
          } else if (a.brandName == 'Nokia') {
            return -1; // 'Nokia' comes before 'b'
          } else if (b.brandName == 'Nokia') {
            return 1; // 'b' comes before 'Nokia'
          } else {
            return 0; // No specific order for other brands
          }
        });
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Colors.grey[200],
              title: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _searchProducts,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_showClearIcon)
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _searchProducts('');
                      },
                      icon: const Icon(Icons.clear),
                    ),
                ],
              ),
            ),
            if (showCarousel)
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: carousels != null && carousels.isNotEmpty
                      ? NewProductsCarousel(newCarousel: carousels)
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Shop by brand',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Add the divider here
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    BrandModel brand = _brands[index];
                    return BrandTile(brandModel: brand);
                  },
                  childCount: _brands.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
