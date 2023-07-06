import 'package:flutter/material.dart';
import 'package:goriber_marketplace/core/utils/product_categories.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/api_response.dart';
import '../entities/product_info.dart';
import '../repositories/product_info_repository.dart';

class ProductInfoViewModel extends ChangeNotifier {
  ProductInfoRepository? repository;
  APIResponse<Failure,List<ProductInfo>>? _allProducts;
  APIResponse<Failure,List<ProductInfo>>? _electronicProducts;
  APIResponse<Failure,List<ProductInfo>>? _jewelleryProducts;
  APIResponse<Failure,List<ProductInfo>>? _menClothes;
  APIResponse<Failure,List<ProductInfo>>? _womenClothes;

  ProductInfoViewModel({this.repository});


  Future<void> fetchAllProducts() async {
    _allProducts = await repository!.getAllProducts();
    notifyListeners();
  }

  Future<void> fetchElectronicProducts() async {
    _electronicProducts = await repository!.getCategoryWiseProducts(ProductCategories.catElectronic);
    notifyListeners();
  }

  Future<void> fetchJewelleryProducts() async {
    _jewelleryProducts = await repository!.getCategoryWiseProducts(ProductCategories.catJewellery);
    notifyListeners();
  }

  Future<void> fetchMenClothes() async {
    _menClothes = await repository!.getCategoryWiseProducts(ProductCategories.catMenCloth);
    notifyListeners();
  }

  Future<void> fetchWomenClothes() async {
    _womenClothes = await repository!.getCategoryWiseProducts(ProductCategories.catWomenCloth);
    notifyListeners();
  }

  APIResponse<Failure,List<ProductInfo>>? get allProducts => _allProducts;
  APIResponse<Failure,List<ProductInfo>>? get electronicProducts => _electronicProducts;
  APIResponse<Failure,List<ProductInfo>>? get jewelleryProducts => _jewelleryProducts;
  APIResponse<Failure,List<ProductInfo>>? get menClothes => _menClothes;
  APIResponse<Failure,List<ProductInfo>>? get womenClothes => _womenClothes;
}