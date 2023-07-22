import 'package:flutter/material.dart';
import 'package:firebase_ecom/Model/brand_model.dart';
import 'package:firebase_ecom/Controller/home_controller.dart';
import 'package:provider/provider.dart';
import '../../providers/brand_provider.dart';

class BrandTile extends StatefulWidget {
  final BrandModel brandModel;

  const BrandTile({Key? key, required this.brandModel}) : super(key: key);

  @override
  BrandTileState createState() => BrandTileState();
}

class BrandTileState extends State<BrandTile> {
  final HomeController _homeController = HomeController();
  late Future<String> _imageUrlFuture;
  String? _cachedImageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = _fetchImageUrl();
  }

  Future<String> _fetchImageUrl() async {
    if (_cachedImageUrl != null) {
      // Return the cached image URL if available
      return _cachedImageUrl!;
    } else {
      // Fetch the image URL from the database
      final imageUrl = await _homeController.getImageUrl(widget.brandModel.brandImage);
      // Cache the image URL for future use
      _cachedImageUrl = imageUrl;
      return imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(
      builder: (context, brandProvider, _) {
        return FutureBuilder<String>(
          future: _imageUrlFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: const EdgeInsets.only(left: 16),
                child: const CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Container(
                margin: const EdgeInsets.only(left: 16),
                child: const Text('Error loading image'),
              );
            }
            final imageUrl = snapshot.data!;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
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
