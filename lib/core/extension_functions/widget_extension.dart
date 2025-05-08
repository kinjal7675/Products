import 'package:demo/features/products/bloc/product_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../features/products/bloc/product_detail_cubit.dart';
import '../injection_container.dart';

extension WidgetExtension on Widget {
  Widget mp() {
    return MultiProvider(
      providers: [
        BlocProvider<ProductListCubit>(
          create: (_) => sl<ProductListCubit>(),
        ),
        BlocProvider<ProductDetailCubit>(
          create: (_) => sl<ProductDetailCubit>(),
        ),
      ],
      child: this,
    );
  }
}
