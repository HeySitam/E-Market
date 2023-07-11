import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/cart_info_viewmodel.dart';
import '../pages/cart_view_page.dart';

class AppBarBuilder extends AppBar{
  AppBarBuilder({super.key});
  static AppBar build({
    required BuildContext context,
    required String title,
    required bool shouldCenterTitle,
    bool shouldCartIconVisible = true,
    double fontSize = 30
  }) {
    return AppBar(
      centerTitle: shouldCenterTitle,
      title: Text(
        title,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.blueGrey,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        Visibility(
          visible: shouldCartIconVisible,
          child: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartViewPage())
              );
            },
            child: Stack(
              children: [
                const SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                Consumer<CartInfoViewModel>(
                  builder: (context,cartVM,child){
                    return Visibility(
                      visible: cartVM.cartInfoList.isNotEmpty,
                      child: CircleAvatar(
                        radius: 12,
                        child: Text("${cartVM.cartInfoList.length}"),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

}