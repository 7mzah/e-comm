import 'package:flutter/material.dart';
import 'package:firebase_ecom/Model/product_model.dart';
import 'package:firebase_ecom/providers/product_provider.dart';
import 'package:firebase_ecom/Controller/home_controller.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  final ProductModel productModel;

  const ProductTile({Key? key, required this.productModel}) : super(key: key);

  @override
  ProductTileState createState() => ProductTileState();
}

class ProductTileState extends State<ProductTile> {
  final HomeController _homeController = HomeController();
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = _homeController.getImageUrl(widget.productModel.image);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        return FutureBuilder<String>(
          future: _imageUrlFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: const EdgeInsets.only(left: 16),
                width: 200,
                height: 200,
                child: const CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Container(
                margin: const EdgeInsets.only(left: 16),
                width: 200,
                height: 200,
                child: const Text('Error loading image'),
              );
            }
            final imageUrl = snapshot.data!;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.network(
                    imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.productModel.brandName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.productModel.phoneName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${widget.productModel.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Color: ${widget.productModel.color}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Storage: ${widget.productModel.storage.toInt()} GB',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
