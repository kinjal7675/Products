part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductListResponse> productList;

  ProductListSuccess(this.productList);
}

class ProductListFailed extends ProductListState {
  final String errorMessage;

  ProductListFailed(this.errorMessage);
}
