class Paginator {
  Paginator({
    required this.currentPage,
    this.itemsPerPage = 30,
  });

  final int currentPage;

  final int itemsPerPage;

  int get offset => (currentPage - 1) * itemsPerPage;

  int get to => (offset + itemsPerPage) - 1;
}
