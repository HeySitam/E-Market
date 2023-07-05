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
});
}

class Rating {
  double? rate;
  double? count;

  Rating({
    this.rate,
    this.count});
}