import 'package:demo/features/products/models/product_list_response.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';

// A stateless widget representing a single product item in a list
class ProductItem extends StatelessWidget {
  final ProductListResponse productItem; // The product data to display

  const ProductItem({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8), // Space around each card
      child: ListTile(
        // Navigate to product detail screen on tap
        onTap: () {
          Navigator.of(context).pushNamed(
            RouteNames.productDetailScreen,
            arguments: productItem.id, // Pass product ID as argument
          );
        },
        contentPadding: const EdgeInsets.all(8), // Padding inside the tile

        // Main title showing the product title
        title: Text(productItem.title),

        // Subtitle showing the description, limited to 2 lines
        subtitle: Text(
          productItem.description.toString(),
          maxLines: 2,
        ),

        // Product image on the left
        leading: Image.network(
          productItem.image,
          width: 100,
        ),

        // Price displayed on the right
        trailing: Text(productItem.price.toString()),
      ),
    );
  }
}
