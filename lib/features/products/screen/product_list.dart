import 'package:demo/core/routes/route_names.dart';
import 'package:demo/features/products/bloc/product_list_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/localization_keys.dart';
import '../widgets/product_item.dart';

// A stateful widget that displays a list of products
class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductListScreenState();
  }
}

// State class for the ProductList screen
class ProductListScreenState extends State<ProductList> {
  late ProductListCubit productListCubit; // Cubit for fetching product list

  @override
  void initState() {
    super.initState();
    getProductList(); // Fetch product list when widget is initialized
  }

  // Method to get product list using the cubit
  void getProductList() async {
    final ProductListCubit productListCubit =
        BlocProvider.of<ProductListCubit>(context);
    productListCubit.getProductList(); // Calls cubit method to fetch products
  }

  @override
  Widget build(BuildContext context) {
    final localization = LocalizationKeys(); // Load localized strings

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes back button
        title: Text(localization.productListTitle), // Title of the screen
        actions: <Widget>[
          // Popup menu for language selection
          PopupMenuButton<String>(
            onSelected: handleClick, // Handles language change
            itemBuilder: (BuildContext context) {
              return {'English', 'Français', 'German'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),

      // Body: listens to state changes from ProductListCubit
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListInitial) {
            // Show loader while fetching data
            return showLoader();
          } else if (state is ProductListSuccess) {
            // Display list of products when data is available
            return ListView.builder(
              itemCount: state.productList.length, // Total number of products
              itemBuilder: (BuildContext context, int index) {
                return ProductItem(
                  productItem: state.productList[index], // Individual product
                );
              },
            );
          } else {
            // Fallback loader for unexpected states
            return showLoader();
          }
        },
      ),
    );
  }

  // Handles language change selection from the menu
  void handleClick(String value) {
    switch (value) {
      case 'English':
        changeLanguage("en");
        break;
      case 'Français':
        changeLanguage("fr");
        break;
      case 'German':
        changeLanguage("de");
        break;
    }
  }

  // Changes the app language and reloads the product list screen
  void changeLanguage(String locale) {
    context.setLocale(Locale(locale)); // Set app-wide locale
    Intl.defaultLocale = locale; // Update default locale for Intl
    Navigator.of(context)
        .pushReplacementNamed(RouteNames.productListScreen); // Reload screen
  }

  // Reusable widget for showing a centered loading indicator
  Widget showLoader() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const CircularProgressIndicator(),
    );
  }
}
