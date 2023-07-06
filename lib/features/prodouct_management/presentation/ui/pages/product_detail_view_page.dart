import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';

class ProductDetailViewPage extends StatelessWidget{
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Electronics",
                style: TextStyle(
                    fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
                ),
              ),
              Expanded(child: VerticalGap(0)),
              Text("See More",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green
                ),)
            ],
          ),
        ),
        ListView()
      ],
    );
  }

  Widget CategoryWiseProductListItem(){
    return Card(
      child: SizedBox(

      ),
    );
  }
}