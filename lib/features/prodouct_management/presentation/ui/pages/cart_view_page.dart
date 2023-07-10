import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/product_detail_view_page.dart';

import '../../../../../core/utils/util.dart';

class CartViewPage extends StatelessWidget {
  const CartViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context,pos) => HorizontalLine(
                    lineWidth: 2,
                    length: MediaQuery.of(context).size.width,
                    color: Colors.black12),
                itemBuilder: (context, pos){
                  return CartListItem();
                }
            ),
          ),
          HorizontalLine(lineWidth: 1,
              length: MediaQuery.of(context).size.width,
          color: Colors.black12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text("₹5190.78",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text("Place Order",
                  style: TextStyle(fontSize: 16),))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CartListItem(){
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(Util.noImageFoundUrl),
      ),
      title: Text("Bamboo Toothbrush",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,),
      subtitle: Row(
        children: [
          Expanded(child: Text("Rs. 120")),
          QuantitySetter()
        ],
      ),
      trailing: Icon(Icons.delete, color: Colors.blueGrey,),
    );
  }
}