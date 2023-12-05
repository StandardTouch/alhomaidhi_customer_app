class AllProductsQuery {
  final int pageNo;
  final String search;
  final String sortBy;
  AllProductsQuery({
    required this.pageNo,
    required this.search,
    required this.sortBy,
  });

  AllProductsQuery copyWith({
    int? pageNo,
    String? search,
    String? sortBy,
  }) {
    return AllProductsQuery(
      pageNo: pageNo ?? this.pageNo,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
