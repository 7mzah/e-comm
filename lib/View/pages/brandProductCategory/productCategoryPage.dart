import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ecom/Model/brand_model.dart';
import 'package:firebase_ecom/Model/product_category_model.dart';

import '../../../Controller/home_controller.dart';

class ProductCategoryPage extends StatefulWidget {
  final BrandModel brand;

  const ProductCategoryPage({Key? key, required this.brand}) : super(key: key);

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  @override
  Widget build(BuildContext context) {
    // Fetch product categories related to the selected brand using the HomeController
    final homeController = Provider.of<HomeController>(context, listen: false);
    final Future<List<CategoryModel>> productCategories =
    Future.value(homeController.fetchAllCategories(widget.brand));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand.brandName),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: productCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading product categories'));
          } else {
            final List<CategoryModel> categories = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the desired cross-axis count here
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.75,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                CategoryModel category = categories[index];
                return ProductCategoryTile(
                  category: category,
                  homeController: homeController,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductCategoryTile extends StatelessWidget {
  final CategoryModel category;
  final HomeController homeController;

  const ProductCategoryTile({
    Key? key,
    required this.category,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category tap here if needed
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<String>(
                future: homeController.getImageUrl(category.imageUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  } else {
                    return CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: snapshot.data!,
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(category.categoryName),
            ),
            // Add other UI elements for the category as needed
          ],
        ),
      ),
    );
  }
}
