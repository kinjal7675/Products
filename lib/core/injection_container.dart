import 'package:demo/features/products/bloc/product_list_cubit.dart';
import 'package:demo/features/products/repo/product_list_repo.dart';
import 'package:demo/features/products/repo/product_list_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/products/bloc/product_detail_cubit.dart';
import '../features/products/repo/product_detail_repo.dart';
import '../features/products/repo/product_detail_repo_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initExternalDependencies();
  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();
}

Future<void> _initExternalDependencies() async {
  sl.registerLazySingleton(() => Dio());
}

Future<void> _initBlocs() async {
  sl.registerFactory(() => ProductListCubit(repository: sl()));
  sl.registerFactory(() => ProductDetailCubit(repository: sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<ProductListRepository>(
      () => ProductListRepositoryImpl(dio: sl()));
  sl.registerLazySingleton<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl(dio: sl()));
}
