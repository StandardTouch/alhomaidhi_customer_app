class AllProductsQuery {
  final int pageNo;
  final String search;
  final String sortBy;
  final int brandId;
  AllProductsQuery({
    required this.pageNo,
    required this.search,
    required this.sortBy,
    required this.brandId,
  });

  AllProductsQuery copyWith({
    int? pageNo,
    String? search,
    String? sortBy,
    int? brandId,
  }) {
    return AllProductsQuery(
      pageNo: pageNo ?? this.pageNo,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      brandId: brandId ?? this.brandId,
    );
  }
}
