import 'package:bloc/bloc.dart';
import 'package:demo/features/products/models/product_list_response.dart';
import 'package:demo/features/products/repo/product_list_repo.dart';
import 'package:meta/meta.dart';
part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListRepository repository;

  ProductListCubit({required this.repository}) : super(ProductListInitial());

  getProductList() async {
    emit(ProductListLoading());
    try {
      final response = await repository.getProductList();
      if (response is List<ProductListResponse>) {
        emit(ProductListSuccess(response));
      } else if (response is ProductListFailed) {
        emit(ProductListFailed(""));
      }
    } catch (e) {
      emit(ProductListFailed(e.toString()));
    }
  }
}
