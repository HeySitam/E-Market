import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_utils.dart';
import '../models/product_info_model.dart';

abstract class ProductInfoRemoteDataSource {
  /// Calls the https://fakestoreapi.com/products endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductInfoModel>> getAllProducts();
    Future<List<ProductInfoModel>> getCategoryWiseProducts(String category);
}

class ProductInfoRemoteDataSourceImpl extends ProductInfoRemoteDataSource {
  final Dio client;

  ProductInfoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductInfoModel>> getAllProducts() async {
    const url = "${NetworkUtil.baseUrl}${NetworkUtil.productsEndPoint}";
    try {
      final response = await client.get(url);
      final allProductsList = (response.data as List)
          .map((productMap) => ProductInfoModel.fromJson(productMap))
          .toList();
        return allProductsList;
    } on DioException catch (e) {
      throw ServerException("${e.message}");
    }
  }

  @override
  Future<List<ProductInfoModel>> getCategoryWiseProducts(String category) async {
    final url = "${NetworkUtil.baseUrl}${NetworkUtil.categoryWiseProductsEndPoint}$category";
    try {
      final response = await client.get(url);
      final allProductsList = (response.data as List)
          .map((productMap) => ProductInfoModel.fromJson(productMap))
          .toList();
      return allProductsList;
    } on DioException catch (e) {
      throw ServerException("${e.message}");
    }
  }
}
