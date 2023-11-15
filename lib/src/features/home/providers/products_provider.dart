import 'package:alhomaidhi_customer_app/src/features/home/models/all_products_response.dart';
import 'package:alhomaidhi_customer_app/src/features/home/models/query_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/services/home_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allProductsProvider =
    FutureProvider.family<AllProductsResponse, AllProductsQuery>(
        (ref, allProductsQuery) async {
  final AllProductsResponse response = await getAllProducts(
      pageNo: allProductsQuery.pageNo,
      search: allProductsQuery.search,
      sortBy: allProductsQuery.sortBy);
  return response;
});
