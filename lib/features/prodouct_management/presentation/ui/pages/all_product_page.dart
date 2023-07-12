import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/enums.dart';
import 'package:goriber_marketplace/core/utils/image_paths.dart';
import 'package:goriber_marketplace/core/utils/product_categories.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/cart_view_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/product_detail_view_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/widgets/my_app_bar.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/widgets/product_image.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/viewmodels/cart_info_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/api_response.dart';
import '../../entities/product_info.dart';
import '../../viewmodels/product_info_viewmodel.dart';
import 'category_wise_product_page.dart';

class AllProductPage extends StatefulWidget{

  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  int _eachCategoryListLen = 5;
  late ProductInfoViewModel vm;
  final _imgHt = 120.0;

  @override
  void initState() {
    vm = Provider.of<ProductInfoViewModel>(context,listen: false);
    vm.fetchElectronicProducts();
    vm.fetchJewelleryProducts();
    vm.fetchMenClothes();
    vm.fetchWomenClothes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    vm.isNetworkConnected();
    return Scaffold(
        appBar: AppBarBuilder.build(
          context: context,
          title: "গরিবের দোকান",
          shouldCenterTitle: true
        ),
        body: Column(
          children:[
            const Padding(
              padding: EdgeInsets.only(left: 18, top: 8),
              child: Text("Welcome!",
                style: TextStyle(fontSize: 30,color: Colors.black38,fontFamily: 'Indies',fontWeight: FontWeight.w500),
              ),
            ),
            HorizontalLine(lineWidth: 1, length: double.infinity,color: Colors.black12),
            Expanded(
              child: Consumer<ProductInfoViewModel>(
                builder: (context, vm, child){
                  return vm.hasNetwork! ? SingleChildScrollView(
                    child:Column(
                      children: [
                        CategoryWiseProducts(heading: CategoryName.catElectronic, response: vm.electronicProducts),
                        CategoryWiseProducts(heading: CategoryName.catJewellery, response: vm.jewelleryProducts),
                        CategoryWiseProducts(heading: CategoryName.catMenCloth, response: vm.menClothes),
                        CategoryWiseProducts(heading: CategoryName.catWomenCloth, response: vm.womenClothes),
                      ],
                    ),
                    // },
                    //   ),
                  ) : Image.asset('assets/images/no_network.png');
                },
              ),
            )] ,
        )
    );
  }

  Widget CategoryWiseProducts({
    required String heading,
    required APIResponse<Failure,List<ProductInfo>>? response}) {
    ResponseState state = response?.responseState ?? ResponseState.LOADING;
    List<ProductInfo>? productInfoList = response?.successResponse;
    _eachCategoryListLen = productInfoList?.length ?? 0;
    return SizedBox(
      height: 248,
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
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CategoryWiseProductViewPage(heading: heading,))
                    );
                  },
                  child: Visibility(
                    visible: state == ResponseState.SUCCESS,
                    child: const Text("See More",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: state == ResponseState.LOADING ? ShimmerLoading() : Stack(
                children: [
                  Visibility(
                    visible: state == ResponseState.SUCCESS,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _eachCategoryListLen,
                        itemBuilder: (context,pos){
                          final item = productInfoList?[pos];
                          return CategoryWiseProductListItem(productInfo: item);
                        }),
                  ),
                  Visibility(
                    visible: state == ResponseState.FAILURE,
                      child: Image.asset(ImagePath.ON_ERROR))
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget CategoryWiseProductListItem({ProductInfo? productInfo}){
    return InkWell(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProductDetailViewPage(info: productInfo!))
        );
      },
      child: Card(
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
            child: productInfo == null ? Image.asset(ImagePath.NO_Item_FOUND,
              height: _imgHt,
              fit: BoxFit.contain,) : ProductImage(
              imgUrl: productInfo.imageUrl,
              imageHt: _imgHt,
            ),
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
              // Text("20 Item availability",
              //   style: TextStyle(fontSize: 10,color: Colors.blueAccent),),
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

  Widget ShimmerLoading(){
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:  ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, pos){
               return Card(
                 elevation: 1.0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(16),
                 ),
                 child: const SizedBox(height: 200, width: 150,),
               );
            }
        )
    );
  }
}