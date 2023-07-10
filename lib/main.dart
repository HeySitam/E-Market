import 'package:flutter/material.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/all_product_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/product_detail_view_page.dart';
import 'package:provider/provider.dart';
import 'features/prodouct_management/presentation/viewmodels/product_info_viewmodel.dart';
import 'product_view_injection_container.dart' as productViewDI;
void main() async {
  await productViewDI.init();
  final productInfoViewModel = productViewDI.sl.get<ProductInfoViewModel>();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => productInfoViewModel),
          ],
          child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto'
      ),
      home: AllProductPage(),
    );
  }
}
