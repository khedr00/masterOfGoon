import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/features/property_feature/data/property_cards_api_service.dart';
import 'package:untitled1/features/property_feature/data/property_cards_query.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_model.dart';

class PropertyCardsProvider extends ChangeNotifier {
  PropertyCardsProvider({PropertyCardsApiService? service})
    : _service = service ?? PropertyCardsApiService();
  final PropertyCardsApiService _service;
  PropertyCardsQuery _query = const PropertyCardsQuery();
  final List<PropertyCardModel> items = [];
  final Set<String> _requestedCursors = <String>{};
  bool isLoading = false;
  Object? error;
  String? _nextCursor;
  bool _hasNext = false;
  CancelToken? _token;
  int _generation = 0;
  bool _disposed = false;
  PropertyCardsQuery get query => _query;
  bool get hasActiveFilters => _query.hasActiveFilters;
  bool get hasActiveSearch => _query.hasActiveSearch;
  bool get canLoadMore => _hasNext && _nextCursor != null && !isLoading && !_requestedCursors.contains(_nextCursor);

  Future<void> loadInitial() => _reload(_query.copyWith(clearCursor: true));
  Future<void> applyFilters(List<PropertyFilter> filters) => _reload(
    _query.copyWith(filters: List.unmodifiable(filters), clearCursor: true),
  );
  Future<void> clearFilters() => applyFilters(const []);
  Future<void> applySearch(String query) =>
      _reload(_query.copyWith(searchQuery: query.trim(), clearCursor: true));
  Future<void> clearSearch() => applySearch('');
  Future<void> applySorting(List<String> orderBy) => _reload(
    _query.copyWith(orderBy: List.unmodifiable(orderBy), clearCursor: true),
  );
  Future<void> loadMore() async {
    if (!canLoadMore) return;
    final cursor = _nextCursor!;
    _requestedCursors.add(cursor);
    await _fetch(_query.copyWith(cursor: cursor), append: true, generation: _generation);
  }

  Future<void> _reload(PropertyCardsQuery query) async {
    _generation++;
    _token?.cancel('A newer property query was started.');
    _query = query;
    items.clear();
    _requestedCursors.clear();
    _nextCursor = null;
    _hasNext = false;
    error = null;
    isLoading = true;
    _notify();
    await _fetch(query, append: false, generation: _generation, alreadyLoading: true);
  }

  Future<void> _fetch(PropertyCardsQuery query, {required bool append, required int generation, bool alreadyLoading = false}) async {
    if (generation != _generation || (!alreadyLoading && isLoading)) return;
    final token = CancelToken();
    _token = token;
    if (!alreadyLoading) {
      isLoading = true;
      error = null;
      _notify();
    }
    try {
      final page = await _service.getProperties(query, cancelToken: token);
      if (generation != _generation || token.isCancelled) return;
      final existingIds = items.map((item) => item.id).where((id) => id.isNotEmpty).toSet();
      for (final item in page.items) {
        // The API property id is the only stable identity exposed by the card model.
        if (item.id.isEmpty || existingIds.add(item.id)) {
          items.add(item);
        }
      }
      _nextCursor = page.nextCursor;
      _hasNext = page.hasNext && _nextCursor != null && _nextCursor!.isNotEmpty;
    } catch (exception) {
      if (generation == _generation && !token.isCancelled) {
        error = exception;
        // Keep the already loaded list intact and make the failed cursor retryable.
        if (append && query.cursor != null) _requestedCursors.remove(query.cursor);
      }
    } finally {
      if (generation == _generation && identical(_token, token)) {
        isLoading = false;
        _notify();
      }
    }
  }

  void _notify() { if (!_disposed) notifyListeners(); }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    _token?.cancel('Property cards provider was disposed.');
    super.dispose();
  }
}
