import 'dart:async';
import 'package:demo/core/extension_functions/widget_extension.dart';
import 'package:demo/features/products/screen/product_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'core/injection_container.dart' as di;
import 'core/l10n/l10n.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/route_names.dart';

void main() {
  di.init().then((value) => runApp(
        EasyLocalization(
          supportedLocales: L10n.all,
          path: 'assets/l10n',
          fallbackLocale: L10n.all[0],
          startLocale: L10n.all[0],
          saveLocale: true,
          child: const MyApp(),
        ).mp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (pc, child) {
          return Builder(
            builder: (builderContext) {
              return MediaQuery(
                data: MediaQuery.of(pc).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          );
        },
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.productListScreen,
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
