import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';
import 'package:provider/provider.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/api_response.dart';
import '../../entities/product_info.dart';
import '../../viewmodels/product_info_viewmodel.dart';

class ProductDetailViewPage extends StatefulWidget{

  const ProductDetailViewPage({super.key});

  @override
  State<ProductDetailViewPage> createState() => _ProductDetailViewPageState();
}

class _ProductDetailViewPageState extends State<ProductDetailViewPage> {
  int _eachCategoryListLen = 5;

  @override
  void initState() {
    final vm = Provider.of<ProductInfoViewModel>(context,listen: false);
    vm.fetchElectronicProducts();
    vm.fetchJewelleryProducts();
    vm.fetchMenClothes();
    vm.fetchWomenClothes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
                "গরিবের দোকান",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Column(
        children:[
          Padding(
            padding: EdgeInsets.only(left: 18, top: 8),
            child: Text("Welcome!",
              style: TextStyle(fontSize: 30,color: Colors.black38,fontFamily: 'Indies',fontWeight: FontWeight.w500),
            ),
          ),
          HorizontalLine(lineWidth: 1, length: double.infinity,color: Colors.black12),
          Expanded(
            child: SingleChildScrollView(
            child: Consumer<ProductInfoViewModel>(
              builder: (context,vm,child){
                return Column(
                  children: [
                    CategoryWiseProducts(heading: "Electronics", response: vm.electronicProducts),
                    CategoryWiseProducts(heading: "Jewellery", response: vm.jewelleryProducts),
                    CategoryWiseProducts(heading: "Men's Clothes", response: vm.menClothes),
                    CategoryWiseProducts(heading: "Women Clothes", response: vm.womenClothes),
                  ],
                );
              },
            ),
        ),
          )] ,
      )
    );
  }

  Widget CategoryWiseProducts({
  required String heading,
  required APIResponse<Failure,List<ProductInfo>>? response}) {
    List<ProductInfo>? productInfoList = response?.successResponse;
    _eachCategoryListLen = productInfoList?.length ?? 0;
    return SizedBox(
      height: 260,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18,right: 20,top: 16,bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(heading,
                  style: const TextStyle(
                      fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54
                  ),
                ),
                Expanded(child: VerticalGap(0)),
                const Text("See More",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green
                  ),)
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _eachCategoryListLen,
                  itemBuilder: (context,pos){
                    final item = productInfoList?[pos];
                return CategoryWiseProductListItem(productInfo: item);
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget CategoryWiseProductListItem({ProductInfo? productInfo}){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            CategoryWiseListItemHeader(productInfo: productInfo),
            CategoryWiseListItemBody(productInfo: productInfo)
          ],
        ),
      ),
    );
  }

  Widget CategoryWiseListItemHeader({ProductInfo? productInfo}){
    return SizedBox(
      width: 150,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)
          ),
          child: ColoredBox(
            color: Colors.white,
            child: productInfo == null ? Image.asset('assets/images/no_item_found.webp',
              height: 120,
              fit: BoxFit.contain,) :
            Image.network(productInfo.imageUrl!,
              height: 120,
              fit: BoxFit.contain,),
          )
      ),
    ) ;
  }

  Widget CategoryWiseListItemBody({ProductInfo? productInfo}){
    final bool isProductInfoNull = productInfo == null;
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isProductInfoNull ? "No data found" : productInfo.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              Text("20 Item availability",
                style: TextStyle(fontSize: 10,color: Colors.blueAccent),),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Visibility(
                  visible: !isProductInfoNull,
                  child: Row(
                    children: [
                      Text("RS.${productInfo!.price!}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),),
                      Expanded(child: VerticalGap(0)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: ColoredBox(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4,right: 4),
                            child: Row(
                              children: [
                                Text(productInfo.rating?.rate?.toString() ?? "0.0",
                                  style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xfff0f0f0)),),
                                Icon(Icons.star_rate_rounded,size: 16,color: Colors.white60,)
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