import 'package:flutter/material.dart';
import 'package:goriber_marketplace/features/prodouct_view/presentation/viewmodels/product_info_viewmodel.dart';
import 'package:provider/provider.dart';

class CategoryWiseProductViewPage extends StatefulWidget {
  const CategoryWiseProductViewPage({super.key});

  @override
  State<CategoryWiseProductViewPage> createState() => _CategoryWiseProductViewPageState();
}

class _CategoryWiseProductViewPageState extends State<CategoryWiseProductViewPage> {
  @override
  void initState() {
    Provider.of<ProductInfoViewModel>(context,listen: false).fetchAllProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
       return Consumer<ProductInfoViewModel>(
         builder:(context, vm, child){
           return Scaffold(
             body: Center(
               child: Container(
                 child: Text(vm.allProducts?.responseState.toString() ?? "Null"),
               ),
             ),
           );
         },
       );
  }
}