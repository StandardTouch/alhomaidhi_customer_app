import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/models/all_products_response.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/models/query_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/services/home_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final allProductsProvider = FutureProvider<AllProductsResponse>((ref) async {
  final query = ref.watch(productQueryProvider);

  final AllProductsResponse response = await getAllProducts(
    pageNo: query.pageNo,
    search: query.search,
    sortBy: query.sortBy,
    brandId: query.brandId,
  );
  return response;
});

class ProductsQueryNotifier extends StateNotifier<AllProductsQuery> {
  ProductsQueryNotifier()
      : super(AllProductsQuery(pageNo: 1, search: "", sortBy: "", brandId: 0));

  void incrementPage() {
    final currentPage = state.pageNo;
    state = state.copyWith(pageNo: currentPage + 1);
  }

  void decrementPage() {
    final currentPage = state.pageNo;
    state = state.copyWith(pageNo: currentPage - 1);
  }

  void updateBrand(int newBrandId) {
    state = state.copyWith(
      brandId: newBrandId,
    );
  }

  void updateSort(String sort) {
    state = state.copyWith(
      sortBy: sort,
    );
  }

  void updateSearch(String search) {
    state = state.copyWith(
      search: search,
    );
  }
}

final productQueryProvider =
    StateNotifierProvider<ProductsQueryNotifier, AllProductsQuery>((ref) {
  return ProductsQueryNotifier();
});
