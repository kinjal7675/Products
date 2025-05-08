import 'package:bloc/bloc.dart';
import 'package:demo/features/products/repo/product_detail_repo.dart';
import 'package:meta/meta.dart';
import '../models/product_detail_response.dart';
part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailRepository repository;

  ProductDetailCubit({required this.repository})
      : super(ProductDetailInitial());

  getProductDetail(int productId) async {
    emit(ProductDetailLoading());
    try {
      final response = await repository.getProductDetail(productId);
      if (response is ProductDetailResponse) {
        emit(ProductDetailSuccess(response));
      } else if (response is ProductDetailFailed) {
        emit(ProductDetailFailed(""));
      }
    } catch (e) {
      emit(ProductDetailFailed(e.toString()));
    }
  }
}
