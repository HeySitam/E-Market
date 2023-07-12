import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goriber_marketplace/core/utils/image_paths.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/ui/pages/all_product_page.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/viewmodels/product_info_viewmodel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _navigateToAllProductPage() async {
   final vm = Provider.of<ProductInfoViewModel>(context,listen: false);
   await vm.isNetworkConnected();
   Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context) => AllProductPage())
   );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Timer(const Duration(seconds: 2), () {
      _navigateToAllProductPage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xff012245),
        child: Center(
          child: Image.asset(ImagePath.APP_LOGO_SPLASH),
        ),
      ),
    );
  }
}
