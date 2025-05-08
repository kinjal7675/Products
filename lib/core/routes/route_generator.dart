import 'dart:math';

import 'package:demo/core/routes/route_names.dart';
import 'package:demo/features/products/screen/product_detail_screen.dart';
import 'package:demo/features/products/screen/product_image_view.dart';
import 'package:demo/features/products/screen/product_list.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  const RouteGenerator();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.productListScreen:
        return MaterialPageRoute(
          builder: (_) => const ProductList(),
        );
      case RouteNames.productDetailScreen:
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(args),
          );
        }
        return errorWidget();

      case RouteNames.productImageViewScreen:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ProductImageView(args),
          );
        }
        return errorWidget();
      default:
        return errorWidget();
    }
  }

  static MaterialPageRoute errorWidget() {
    return MaterialPageRoute(
      builder: (_) => const SizedBox(),
    );
  }
}
