import 'package:flutter/material.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/widgets/toggle_button.dart';
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
    bool shouldToggleBtnVisible = false,
    double fontSize = 30,
    SelectedStateCallBack? stateCallBack
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
      backgroundColor: const Color(0xff012245),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        Visibility(
            visible: shouldToggleBtnVisible,
            child: ColumnGridToggleButton(selectedState: (toggleState) => stateCallBack!(toggleState))),
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