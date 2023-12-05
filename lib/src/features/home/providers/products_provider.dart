import 'package:alhomaidhi_customer_app/src/features/home/models/all_products_response.dart';
import 'package:alhomaidhi_customer_app/src/features/home/models/query_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/services/home_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allProductsProvider = FutureProvider<AllProductsResponse>((ref) async {
  final query = ref.watch(productQueryProvider);

  final AllProductsResponse response = await getAllProducts(
    pageNo: query.pageNo,
    search: query.search,
    sortBy: query.sortBy,
  );
  return response;
});

class ProductsQueryNotifier extends StateNotifier<AllProductsQuery> {
  ProductsQueryNotifier()
      : super(AllProductsQuery(pageNo: 1, search: "", sortBy: ""));

  void incrementPage() {
    final currentPage = state.pageNo;
    state = state.copyWith(pageNo: currentPage + 1);
  }

  void decrementPage() {
    final currentPage = state.pageNo;
    state = state.copyWith(pageNo: currentPage - 1);
  }
}

final productQueryProvider =
    StateNotifierProvider<ProductsQueryNotifier, AllProductsQuery>((ref) {
  return ProductsQueryNotifier();
});
