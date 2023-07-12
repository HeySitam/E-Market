import 'package:flutter/material.dart';
import 'package:goriber_marketplace/features/prodouct_management/presentation/entities/product_info.dart';

import '../../../../../core/utils/image_paths.dart';
import '../../../../../core/utils/util.dart';

class ProductImage extends StatelessWidget {
  String? imgUrl;
  double? imageHt;
  ProductImage({super.key, required this.imgUrl, this.imageHt});
  @override
  Widget build(BuildContext context) {
    return Image.network(imgUrl ?? Util.noImageFoundUrl,
      height: imageHt,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progressEvent){
        if(progressEvent == null) return child;
        return Image.asset(ImagePath.NO_IMG_FOUND,
          height: imageHt,
          fit: BoxFit.cover,
        );
      },
      errorBuilder: (context, object, strace){
        return Image.asset(ImagePath.NO_IMG_FOUND,
          height: imageHt,
          fit: BoxFit.cover,
        );
      },
    );
  }

}