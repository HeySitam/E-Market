import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';

class ProductDetailViewPage extends StatelessWidget{
  final _eachCategoryListLen = 5;
  const ProductDetailViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20,top: 28,bottom: 8),
            child: Row(
              children: [Text(
                  "Goriber Dokan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey
                ),
              ),
                Expanded(child: VerticalGap(0)),
                Icon(
                  Icons.shopping_cart,
                  color: Colors.blueGrey,
                )
              ],

            ),
          ),
          HorizontalLine(
              lineWidth: 2,
              length: MediaQuery.of(context).size.width,
            color: Colors.black12
          ),
          ElectronicProducts()
        ],
      ),
    );
  }

  Widget ElectronicProducts() {
    return SizedBox(
      height: 260,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Electronics",
                  style: TextStyle(
                      fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54
                  ),
                ),
                Expanded(child: VerticalGap(0)),
                Text("See More",
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
                return CategoryWiseProductListItem();
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget CategoryWiseProductListItem(){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)
                ),
                  child: Image.asset('assets/images/grocery.webp',
                  fit: BoxFit.cover,)),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Market Place",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    Text("20 Item availability",
                      style: TextStyle(fontSize: 10,color: Colors.redAccent),),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Text("RS.120",
                            style: TextStyle(
                                fontSize: 16,
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
                                    Text("3.8",
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}