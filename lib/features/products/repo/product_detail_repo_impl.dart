import 'dart:convert';
import 'package:demo/core/api/api_service.dart';
import 'package:demo/core/constant/app_urls.dart';
import 'package:demo/features/products/models/product_detail_response.dart';
import 'package:demo/features/products/repo/product_detail_repo.dart';
import 'package:dio/dio.dart';

class ProductDetailRepositoryImpl extends ProductDetailRepository {
  final Dio dio;

  ProductDetailRepositoryImpl({required this.dio});

  @override
  getProductDetail(int productId) async {
    Response? response = await ApiService.getApi(
        dio: dio, url: AppUrls.products + "/" + productId.toString(), data: {});
    if (response?.statusCode == 200) {
      final ProductDetailResponse productDetailResponse =
          productDetailResponseFromJson(json.encode(response?.data));

      return productDetailResponse;
    }
    return null;
  }
}
