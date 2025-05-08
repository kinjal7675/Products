part of 'product_detail_cubit.dart';

@immutable
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductDetailResponse productDetailResponse;

  ProductDetailSuccess(this.productDetailResponse);
}

class ProductDetailFailed extends ProductDetailState {
  final String errorMessage;

  ProductDetailFailed(this.errorMessage);
}
