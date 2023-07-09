import 'package:goriber_marketplace/core/utils/supporting_methods.dart';

class ProductInfo {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? imageUrl;
  Rating? rating;

  ProductInfo({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.imageUrl,
    this.rating
}){
    price = roundDoubleToTwoDecimalPlace(price ?? 0.0);
  }
}

class Rating {
  double? rate;
  double? count;

  Rating({
    this.rate,
    this.count});
}