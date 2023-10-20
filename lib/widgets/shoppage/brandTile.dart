import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ecom/Model/brand_model.dart';
import 'package:provider/provider.dart';
import '../../providers/brand_provider.dart';
import '../../Controller/home_controller.dart'; // Import HomeController

class BrandTile extends StatefulWidget {
  final BrandModel brandModel;

  const BrandTile({Key? key, required this.brandModel}) : super(key: key);

  @override
  BrandTileState createState() => BrandTileState();
}

class BrandTileState extends State<BrandTile> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = HomeController().getImageUrl(widget.brandModel.brandImage); // Use HomeController to fetch the image URL
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
                child: const Center(child: CircularProgressIndicator()),
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
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
