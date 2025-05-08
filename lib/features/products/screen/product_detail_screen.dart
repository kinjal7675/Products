import 'package:demo/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constant/localization_keys.dart';
import '../../../core/routes/route_names.dart';
import '../bloc/product_detail_cubit.dart';

// Main widget class representing the product detail screen
class ProductDetailScreen extends StatefulWidget {
  final int productId; // Product ID to fetch details
  const ProductDetailScreen(this.productId, {super.key});

  @override
  State<StatefulWidget> createState() {
    return ProductDetailScreenState();
  }
}

// State class for ProductDetailScreen
class ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    getProductDetail(); // Fetch product details on initialization
  }

  // Calls the cubit's method to load product details
  void getProductDetail() async {
    final ProductDetailCubit productListCubit =
        BlocProvider.of<ProductDetailCubit>(context);
    productListCubit.getProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final localization = LocalizationKeys(); // Load localization keys

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.productDetailTitle), // Screen title
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitial) {
            // Show loading spinner when data is being fetched
            return showLoader();
          } else if (state is ProductDetailSuccess) {
            // Once data is successfully fetched, show product details
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image with tap to view full image
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteNames.productImageViewScreen,
                        arguments: state.productDetailResponse.image,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Image.network(
                        state.productDetailResponse.image,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Product title
                  Text(
                    state.productDetailResponse.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Product description
                  Text(
                    state.productDetailResponse.description,
                    style: const TextStyle(color: greyColor),
                  ),
                  const SizedBox(height: 10),
                  // Product category
                  Text(
                    "Category: ${state.productDetailResponse.category.toString()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Product price
                  Text(
                    "Price: ${state.productDetailResponse.price.toString()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Rating bar showing average rating
                  RatingBarIndicator(
                    rating: state.productDetailResponse.rating.rate,
                    itemCount: 5,
                    itemSize: 30.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: greenColor,
                    ),
                  ),
                  const Spacer(),
                  // Share button to share product title and price
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: whiteColor,
                        backgroundColor: orangeColor, // Button background
                      ),
                      onPressed: () {
                        Share.share(
                          state.productDetailResponse.title,
                          subject: state.productDetailResponse.price.toString(),
                        );
                      },
                      child: Text(
                        localization.shareTitle,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            // Fallback to loader for other states
            return showLoader();
          }
        },
      ),
    );
  }

  // Widget to display a loading indicator
  Widget showLoader() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const CircularProgressIndicator(),
    );
  }
}
