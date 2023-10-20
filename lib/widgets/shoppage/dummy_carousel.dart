import 'package:flutter/material.dart';

class DummyCarousel extends StatelessWidget {
  const DummyCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Set the desired height here
      child: PageView.builder(
        itemCount: 3, // Replace this with the actual number of pages
        itemBuilder: (context, index) {
          // Replace this with your custom page content for each index
          return Container(
            color: Colors.grey[300],
          );
        },
      ),
    );
  }
}
