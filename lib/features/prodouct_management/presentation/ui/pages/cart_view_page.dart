import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/supporting_widgets.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/entities/cart_info.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/product_detail_view_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/viewmodels/cart_info_viewmodel.dart';
import 'package:provider/provider.dart';

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
            child: Consumer<CartInfoViewModel>(
              builder: (context, vm, child){
                final cartInfoList = vm.cartInfoList;
                return ListView.separated(
                    itemCount: cartInfoList.length,
                    separatorBuilder: (context,pos) => HorizontalLine(
                        lineWidth: 2,
                        length: MediaQuery.of(context).size.width,
                        color: Colors.black12),
                    itemBuilder: (context, pos){
                      return CartListItem(cartInfoList[pos],context);
                    }
                );
              },
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
                  child: Consumer<CartInfoViewModel>(
                    builder: (context,vm,chiild){
                      return Text("₹${vm.calculateTotal()}",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),);
                    },
                  ),
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

  Widget CartListItem(CartInfo cartInfo,BuildContext context){
    final cartVM = Provider.of<CartInfoViewModel>(context,listen: false);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(cartInfo.imgUrl ?? Util.noImageFoundUrl),
      ),
      title: Text(cartInfo.title ?? "Not Found!",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,),
      subtitle: Row(
        children: [
          Expanded(child: Text("Rs. ${cartInfo.price ?? 0.0}")),
          QuantitySetter(
            qtyCallBack: (qty) => cartVM.editItemQuantity(cartInfo.id!, qty),
            productId: cartInfo.id!,
          )
        ],
      ),
      trailing: InkWell(
          onTap: (){
            cartVM.deleteFromCart(cartInfo.id!);
          },
          child: Icon(Icons.delete, color: Colors.blueGrey,)),
    );
  }
}