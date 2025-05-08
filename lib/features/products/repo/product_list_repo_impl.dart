import 'dart:convert';
import 'package:demo/core/api/api_service.dart';
import 'package:demo/core/constant/app_urls.dart';
import 'package:demo/features/products/models/product_list_response.dart';
import 'package:demo/features/products/repo/product_list_repo.dart';
import 'package:dio/dio.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  final Dio dio;

  ProductListRepositoryImpl({required this.dio});

  @override
  getProductList() async {
    Response? response =
        await ApiService.getApi(dio: dio, url: AppUrls.products, data: {});
    if (response?.statusCode == 200) {
      final List<ProductListResponse> productListResponse =
          productListResponseFromJson(json.encode(response?.data));
      return productListResponse;
    }
    return null;
  }
}
