import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/property_cards_query.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_model.dart';
import 'package:untitled1/providers/theme_provider.dart';

Widget _dialogButton(BuildContext context, String text, VoidCallback action) {
  final width = MediaQuery.sizeOf(context).width;
  return ButtonWithText(
    buttonAction: action,
    widthOfButton: (width * (120 / 1920)).clamp(88, 120).toDouble(),
    heightOfButton: (width * (42 / 1920)).clamp(36, 42).toDouble(),
    text: text,
  );
}

class PropertySearchDialog extends StatefulWidget {
  const PropertySearchDialog({super.key, required this.initial});
  final String initial;
  @override
  State<PropertySearchDialog> createState() => _PropertySearchDialogState();
}

class _PropertySearchDialogState extends State<PropertySearchDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return AlertDialog(
      backgroundColor: dark ? darkSecondaryColor : secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Search properties',
        style: TextStyle(
          fontFamily: 'NunitoSans-Bold',
          color: getPrimaryTextColor(dark),
        ),
      ),
      content: SizedBox(
        width: 380,
        child: TextField(
          controller: _controller,
          autofocus: true,
          onSubmitted: (value) => Navigator.pop(context, value),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search',
            filled: true,
            fillColor: getInputBackgroundColor(dark),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      actions: [
        if (widget.initial.isNotEmpty)
          _dialogButton(context, 'Clear', () => Navigator.pop(context, '')),
        _dialogButton(context, 'Cancel', () => Navigator.pop(context)),
        _dialogButton(
          context,
          'Search',
          () => Navigator.pop(context, _controller.text),
        ),
      ],
    );
  }
}

class PropertyFilterDialog extends StatefulWidget {
  const PropertyFilterDialog({
    super.key,
    required this.initial,
    required this.properties,
  });
  final List<PropertyFilter> initial;
  final List<PropertyCardModel> properties;
  @override
  State<PropertyFilterDialog> createState() => _PropertyFilterDialogState();
}

class _PropertyFilterDialogState extends State<PropertyFilterDialog> {
  late Set<String> _types;
  late Set<String> _listingTypes;
  late Set<String> _cities;
  late _PriceBounds _bounds;
  late RangeValues _priceRange;

  @override
  void initState() {
    super.initState();
    _types = _valuesFor('type').toSet();
    _listingTypes = _valuesFor('listingType').toSet();
    _cities = _valuesFor('city').toSet();
    _bounds = _PriceBounds.fromProperties(widget.properties);
    _priceRange = _bounds.normalized(_initialPriceRange());
  }

  List<String> _valuesFor(String field) => widget.initial
      .where(
        (filter) =>
            filter.field == field &&
            filter.operator == PropertyFilterOperator.equals,
      )
      .map((filter) => filter.value)
      .where((value) => value.isNotEmpty)
      .toList();
  RangeValues _initialPriceRange() {
    final lower = _numberFilter(PropertyFilterOperator.gte) ?? _bounds.min;
    final upper = _numberFilter(PropertyFilterOperator.lte) ?? _bounds.max;
    return RangeValues(lower, upper);
  }

  double? _numberFilter(PropertyFilterOperator operator) {
    for (final filter in widget.initial) {
      if (filter.field == 'listedPrice' && filter.operator == operator) {
        return double.tryParse(filter.value);
      }
    }
    return null;
  }

  List<String> _options(Iterable<String> values, Set<String> selected) => {
    ...values.where((value) => value.trim().isNotEmpty),
    ...selected,
  }.toList()..sort();
  void _toggle(Set<String> values, String value, bool selected) =>
      setState(() => selected ? values.add(value) : values.remove(value));

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 560,
          maxHeight: MediaQuery.sizeOf(context).height * .85,
        ),
        child: Material(
          color: dark ? darkSecondaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filter properties',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: 24,
                          color: getPrimaryTextColor(dark),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _section(
                        'Property type',
                        _chips(
                          _options(
                            widget.properties.map((item) => item.type),
                            _types,
                          ),
                          _types,
                        ),
                      ),
                      _section(
                        'Listing type',
                        _chips(
                          _options(
                            widget.properties.map((item) => item.listingType),
                            _listingTypes,
                          ),
                          _listingTypes,
                        ),
                      ),
                      _section(
                        'City',
                        _chips(
                          _options(
                            widget.properties.map((item) => item.city),
                            _cities,
                          ),
                          _cities,
                        ),
                      ),
                      _priceSection(dark),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _dialogButton(context, 'Reset', _clear),
                    _dialogButton(
                      context,
                      'Cancel',
                      () => Navigator.pop(context),
                    ),
                    _dialogButton(
                      context,
                      'Apply',
                      () => Navigator.pop(context, _result()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, Widget content) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'NunitoSans-SemiBold',
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        content,
      ],
    ),
  );
  Widget _chips(List<String> options, Set<String> selected) => options.isEmpty
      ? const Text('No values are available yet.')
      : Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options
              .map(
                (value) => FilterChip(
                  label: Text(_label(value)),
                  selected: selected.contains(value),
                  onSelected: (isSelected) =>
                      _toggle(selected, value, isSelected),
                ),
              )
              .toList(),
        );
  String _label(String value) => value
      .replaceAll('_', ' ')
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map(
        (part) => '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
      )
      .join(' ');
  Widget _priceSection(bool dark) => _section(
    'Price range',
    !_bounds.hasUsableRange
        ? Text(
            _bounds.hasPrices
                ? 'All available properties have the same price: ${_money(_bounds.min)}.'
                : 'Price filtering is unavailable until property prices are loaded.',
            style: TextStyle(color: getSecondaryTextColor(dark)),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_money(_priceRange.start)),
                  Text(_money(_priceRange.end)),
                ],
              ),
              RangeSlider(
                values: _priceRange,
                min: _bounds.min,
                max: _bounds.max,
                divisions: _bounds.divisions,
                labels: RangeLabels(
                  _money(_priceRange.start),
                  _money(_priceRange.end),
                ),
                onChanged: (value) =>
                    setState(() => _priceRange = _bounds.normalized(value)),
              ),
            ],
          ),
  );
  String _money(double amount) => '\$${amount.round()}';
  void _clear() => setState(() {
    _types.clear();
    _listingTypes.clear();
    _cities.clear();
    _priceRange = _bounds.fullRange;
  });
  List<PropertyFilter> _result() {
    final filters = <PropertyFilter>[];
    void addAll(String field, Set<String> values) {
      for (final value in values) {
        filters.add(PropertyFilter(field, value));
      }
    }

    addAll('type', _types);
    addAll('listingType', _listingTypes);
    addAll('city', _cities);
    if (_bounds.hasUsableRange) {
      if (_priceRange.start > _bounds.min) {
        filters.add(
          PropertyFilter(
            'listedPrice',
            _priceRange.start.round().toString(),
            operator: PropertyFilterOperator.gte,
          ),
        );
      }
      if (_priceRange.end < _bounds.max) {
        filters.add(
          PropertyFilter(
            'listedPrice',
            _priceRange.end.round().toString(),
            operator: PropertyFilterOperator.lte,
          ),
        );
      }
    }
    return filters;
  }
}

class _PriceBounds {
  const _PriceBounds(this.min, this.max, this.hasPrices);
  factory _PriceBounds.fromProperties(List<PropertyCardModel> properties) {
    final prices = properties
        .map(
          (item) => double.tryParse(
            item.listedPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
          ),
        )
        .whereType<double>()
        .where((value) => value.isFinite)
        .toList();
    if (prices.isEmpty) return const _PriceBounds(0, 1, false);
    prices.sort();
    return _PriceBounds(prices.first, prices.last, true);
  }
  final double min;
  final double max;
  final bool hasPrices;
  bool get hasUsableRange => hasPrices && max > min;
  int? get divisions {
    if (!hasUsableRange) return null;
    final span = (max - min).abs();
    return span.round().clamp(1, 100);
  }

  RangeValues get fullRange => RangeValues(min, max);
  RangeValues normalized(RangeValues value) {
    final start = value.start.isFinite
        ? value.start.clamp(min, max).toDouble()
        : min;
    final end = value.end.isFinite ? value.end.clamp(min, max).toDouble() : max;
    return start <= end ? RangeValues(start, end) : RangeValues(end, start);
  }
}
