import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';
import 'package:goriber_marketplace/core/utils/util.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/entities/cart_info.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/cart_view_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/widgets/my_app_bar.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/widgets/product_image.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/viewmodels/cart_info_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/api_response.dart';
import '../../entities/product_info.dart';
import '../../viewmodels/product_info_viewmodel.dart';
import '../widgets/quantity_setter.dart';

class ProductDetailViewPage extends StatelessWidget {
  final _imgHt = 300.0;
  final _btnSize = 80.0;
  int _selectedQty = 1;

  //final desc = "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.";

  ProductInfo info;

  ProductDetailViewPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final cartVM = Provider.of<CartInfoViewModel>(context, listen: false);
    return Scaffold(
        appBar: AppBarBuilder.build(
            context: context,
            title: "",
            shouldCenterTitle: false),
        body: Column(
          children: [
            Expanded(child: ProductImage(imgUrl: info.imageUrl)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(info.title ?? "Not Found",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ColoredBox(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4, right: 4),
                              child: Row(
                                children: [
                                  Text(info.rating?.rate?.toString() ?? "0.0",
                                    style: const TextStyle(fontWeight: FontWeight.w500,
                                        color: Color(0xfff0f0f0)),),
                                  const Icon(Icons.star_rate_rounded, size: 16,
                                    color: Colors.white60,)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("Rs. ${info.price ?? 0.0}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(info.description ?? "no description found!",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 12),
                    //   child: Row(
                    //     children: [
                    //       Expanded(child: Text("Select Qty.",
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500
                    //         ),),),
                    //       Padding(
                    //           padding: EdgeInsets.only(right: 12),
                    //           child: QuantitySetter(qtyCallBack: _selectedQtyCallBack, productId: info.id!,))
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () {
                    final cartInfo = CartInfo(
                      id: info.id,
                      title: info.title,
                      price: info.price,
                      qty: _selectedQty,
                      imgUrl: info.imageUrl
                    );
                    cartVM.addToCart(cartInfo);
                  },
                  child: Container(
                    width: _btnSize,
                    height: _btnSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff012245)),
                    child: const Icon(Icons.add_shopping_cart, color: Colors.white,
                      size: 40,),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}


