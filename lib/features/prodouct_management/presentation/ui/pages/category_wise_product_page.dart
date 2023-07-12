import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/image_paths.dart';
import 'package:goriber_marketplace/core/utils/product_categories.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/product_detail_view_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/supporting_widgets.dart';
import '../../entities/product_info.dart';
import '../../viewmodels/cart_info_viewmodel.dart';
import '../../viewmodels/product_info_viewmodel.dart';
import '../widgets/product_image.dart';
import '../widgets/toggle_button.dart';
import 'cart_view_page.dart';

class CategoryWiseProductViewPage extends StatefulWidget {
  String heading;
  CategoryWiseProductViewPage({super.key,required this.heading});

  @override
  State<CategoryWiseProductViewPage> createState() =>
      _CategoryWiseProductViewPageState();
}

class _CategoryWiseProductViewPageState
    extends State<CategoryWiseProductViewPage> {
  List<ProductInfo>? productInfoList;
  final _gridImgHt = 100.0;
  final _colImgHt = 260.0;
  bool _isColumn = true;

  @override
  void initState() {
    final vm = Provider.of<ProductInfoViewModel>(context, listen: false);
    switch(widget.heading){
      case CategoryName.catElectronic:{
        productInfoList = vm
            .electronicProducts!
            .successResponse;
        break;
      }
      case CategoryName.catJewellery:{
        productInfoList = vm
            .jewelleryProducts!
            .successResponse;
        break;
      }
      case CategoryName.catMenCloth:{
        productInfoList = vm
            .menClothes!
            .successResponse;
        break;
      }
      case CategoryName.catWomenCloth:{
        productInfoList = vm
            .womenClothes!
            .successResponse;
        break;
      }

    }

    super.initState();
  }

  _selectedStateCallBack(ToggleSate state) {
    if (state == ToggleSate.COLUMN) {
      _isColumn = true;
    } else {
      _isColumn = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBarBuilder.build(
              context: context,
              title: widget.heading,
              fontSize: 24,
              shouldCenterTitle: false,
              shouldToggleBtnVisible: true,
              stateCallBack: _selectedStateCallBack
          ),
          body: _isColumn ? ColumnList() : GridList(),
        );
  }

  Widget ColumnList() {
    return ListView.builder(
        itemCount: productInfoList!.length,
        itemBuilder: (context, pos) {
          return CategoryWiseProductListItem(
              productInfo: productInfoList![pos]);
        });
  }

  Widget GridList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: productInfoList!.length,
        itemBuilder: (context, pos) {
          return CategoryWiseProductListItem(
              productInfo: productInfoList![pos]);
        });
  }

  Widget CategoryWiseProductListItem({ProductInfo? productInfo}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductDetailViewPage(info: productInfo!))
            );
          },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              CategoryWiseListItemHeader(productInfo: productInfo),
              CategoryWiseListItemBody(productInfo: productInfo)
            ],
          ),
        ),
      ),
    );
  }

  Widget CategoryWiseListItemHeader({ProductInfo? productInfo}) {
    return SizedBox(
      width: double.infinity,
      height: _isColumn ? _colImgHt : _gridImgHt,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: ColoredBox(
              color: Colors.white,
              child: productInfo == null ? Image.asset(ImagePath.NO_Item_FOUND,
                fit: BoxFit.contain,) : ProductImage(
                imgUrl: productInfo.imageUrl,
              ),
            )),
      ),
    );
  }

  Widget CategoryWiseListItemBody({ProductInfo? productInfo}) {
    final bool isProductInfoNull = productInfo == null;
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isProductInfoNull ? "No data found" : productInfo.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Visibility(
                  visible: !isProductInfoNull,
                  child: Row(
                    children: [
                      Text(
                        "RS.${productInfo!.price!}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: VerticalGap(0)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: ColoredBox(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Row(
                              children: [
                                Text(
                                  productInfo.rating?.rate?.toString() ?? "0.0",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xfff0f0f0)),
                                ),
                                const Icon(
                                  Icons.star_rate_rounded,
                                  size: 16,
                                  color: Colors.white60,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


