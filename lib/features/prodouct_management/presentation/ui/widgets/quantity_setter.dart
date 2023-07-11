import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/cart_info_viewmodel.dart';


class QuantitySetter extends StatelessWidget {
  int _qty = 1;
  late CartInfoViewModel cartVM;

  int productId;
  QuantitySetter({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
   final cartVM = Provider.of<CartInfoViewModel>(context,listen: true);
   _qty = cartVM.getSelectedQty(productId);
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (_qty > 1) {
                  _qty --;
                  cartVM.updateSelectedQty(productId, _qty);
                }
              },
              child: Center(
                child: Text('-',
                  style: TextStyle(color: Colors.green, fontSize: 20),),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(cartVM.getSelectedQty(productId).toString(),
                style: TextStyle(color: Colors.black, fontSize: 16),),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (_qty < 50) {
                  _qty ++;
                  cartVM.updateSelectedQty(productId, _qty);
                }
              },
              child: Center(
                child: Text('+',
                  style: TextStyle(color: Colors.green, fontSize: 20),),
              ),
            ),
          )
        ],
      ),
    );
  }
}