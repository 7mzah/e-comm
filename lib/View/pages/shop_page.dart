import 'package:firebase_ecom/Model/brand_model.dart';
import 'package:firebase_ecom/Model/carousel_model.dart';
import 'package:firebase_ecom/providers/brand_provider.dart';
import 'package:firebase_ecom/widgets/shoppage/brandTile.dart';
import 'package:firebase_ecom/widgets/shoppage/dummy_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/carousel_provider.dart';
import '../../widgets/shoppage/new_products_carousel.dart';
import 'brandProductCategory/productCategoryPage.dart';

class ShopPage extends StatefulWidget {
  const ShopPage(
      {Key? key,
      required List<BrandModel> brands,
      required List<CarouselModel> carousel})
      : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late List<BrandModel> _brands;
  final TextEditingController _searchController = TextEditingController();
  bool _showClearIcon = false; // Variable to control clear icon visibility

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts(String query) {
    setState(() {
      _showClearIcon = query.isNotEmpty; // Update the clear icon visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2< BrandProvider, CarouselProvider>(
      builder: (context, brandProvider, carouselProvider, _) {
        final List<CarouselModel> carousels = carouselProvider.carouselImages;
        _brands = brandProvider.brands;
        if (_brands.isEmpty) {
          // If _brands is null or empty, show a loading indicator or empty state
          return const Center(child: CircularProgressIndicator());
        }

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
                  child: carousels.isEmpty
                      ? const DummyCarousel()
                      : NewProductsCarousel(newCarousel: carousels),
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
                    return GestureDetector(
                        onTap: () {
                          // Navigate to the product category page when the brand is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductCategoryPage(brand: brand),
                            ),
                          );
                        },
                        child: BrandTile(brandModel: brand));
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
