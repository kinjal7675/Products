import 'package:demo/core/constant/color.dart';
import 'package:flutter/material.dart';

// A stateless widget to display a fullscreen image
class ProductImageView extends StatelessWidget {
  final String path; // The URL/path of the image to display

  const ProductImageView(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackTransColor, // Semi-transparent black background

      // AppBar with same background to match the fullscreen theme
      appBar: AppBar(
        backgroundColor: blackTransColor,
      ),

      // Centered image display
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(path), // Loads image from the network
      ),
    );
  }
}
