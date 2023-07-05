import 'package:goriber_marketplace/features/prodouct_view/presentation/entities/product_info.dart';

class ProductInfoModel extends ProductInfo {
  ProductInfoModel({
      super.id,
      super.title,
      super.price,
      super.description,
      super.category,
      super.imageUrl,
      super.rating});

  factory ProductInfoModel.fromJson(Map<String, dynamic> json){
      return ProductInfoModel(
          id: json['id'],
          title: json['title'],
          price: json['price'],
          description: json['description'],
          category: json['category'],
          imageUrl: json['image'],
          rating: json['rating'],
      );
  }
}

class RatingModel extends Rating{
    RatingModel({super.rate,super.count});

    factory RatingModel.fromJson(Map<String, dynamic> json){
        return RatingModel(
            rate: json['rate'],
            count: json['count']
        );
    }
}