import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/property_cards_query.dart';
import 'package:untitled1/features/property_feature/providers/property_cards_provider.dart';
import 'package:untitled1/features/property_feature/providers/property_data_provider.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/apartment_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/hall_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/house_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/store_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/villa_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_mini_cards_viewer/property_query_dialogs.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PropertyMiniCardsViewer extends StatefulWidget {
  const PropertyMiniCardsViewer({super.key});
  @override State<PropertyMiniCardsViewer> createState() => _PropertyMiniCardsViewerState();
}

class _PropertyMiniCardsViewerState extends State<PropertyMiniCardsViewer> {
  final _scrollController = ScrollController();
  final _cards = PropertyCardsProvider();

  @override void initState() {
    super.initState();
    context.read<PropertyDataProvider>().selectProperty(null);
    _scrollController.addListener(_loadMore);
    _cards.loadInitial().then((_) { if (mounted && _cards.items.isNotEmpty) context.read<PropertyDataProvider>().selectProperty(_cards.items.first.id); });
  }
  void _loadMore() {
    if (_scrollController.hasClients &&
        _scrollController.position.extentAfter <= 200 &&
        _cards.canLoadMore) {
      _cards.loadMore();
    }
  }
  @override void dispose() { _scrollController.dispose(); _cards.dispose(); super.dispose(); }
  Future<void> _filters() async { final filters = await showDialog<List<PropertyFilter>>(context: context, builder: (_) => PropertyFilterDialog(initial: _cards.query.filters, properties: _cards.items)); if (filters != null) await _cards.applyFilters(filters); }
  Future<void> _search() async { final value = await showDialog<String>(context: context, builder: (_) => PropertySearchDialog(initial: _cards.query.searchQuery)); if (value != null) await _cards.applySearch(value); }

  @override Widget build(BuildContext context) => ChangeNotifierProvider.value(value: _cards, child: Consumer<PropertyCardsProvider>(builder: (context, cards, _) => _viewer(context, cards)));
  Widget _viewer(BuildContext context, PropertyCardsProvider cards) {
    final theme = context.watch<ThemeProvider>(); final width = MediaQuery.of(context).size.width;
    if (cards.items.isEmpty && cards.isLoading) return Container(color: theme.isDarkMode ? darkBackGroundColor : backGroundColor, child: const Center(child: CircularProgressIndicator()));
    return SizedBox(width: width * (381 / 1920), height: width * (951 / 1920), child: Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: width * (30 / 1920)), child: Row(children: [
        Padding(padding: EdgeInsets.only(left: width * (28 / 1920), right: width * (28 / 1920)), child: ButtonWithImage(image: 'assets/images/Slider.png', widthOfButton: width * (60 / 1920), heightOfButton: width * (40 / 1920), heightOfImage: width * (30 / 1920), widthOfImage: width * (30 / 1920), buttonAction: _filters)),
        ButtonWithImage(image: 'assets/images/Search.png', widthOfButton: width * (60 / 1920), heightOfButton: width * (40 / 1920), heightOfImage: width * (30 / 1920), widthOfImage: width * (30 / 1920), buttonAction: _search),
      ])),
      SizedBox(height: width * (850 / 1920), child: cards.error != null && cards.items.isEmpty ? const Center(child: Text('Unable to load properties')) : cards.items.isEmpty ? const SizedBox() : ListView.builder(controller: _scrollController, itemCount: cards.items.length + (cards.isLoading ? 1 : 0), itemBuilder: (context, index) {
        if (index == cards.items.length) return Padding(padding: EdgeInsets.all(width * (15 / 1920)), child: const Center(child: CircularProgressIndicator()));
        final item = cards.items[index];
        return Padding(padding: EdgeInsets.symmetric(vertical: width * (20 / 1920)), child: GestureDetector(onTap: () => context.read<PropertyDataProvider>().selectProperty(item.id), child: _card(item.type, item)));
      })),
    ]));
  }
  Widget _card(String type, dynamic item) { switch (type) { case 'VILLA': return VillaMiniCard(villaCardModuleInfo: item); case 'HOUSE': return HouseMiniCard(houseCardModuleInfo: item); case 'HALL': return HallMiniCard(hallCardModuleInfo: item); case 'STORE': return StoreMiniCard(storeCardModuleInfo: item); case 'APARTMENT': return ApartmentMiniCard(apartmentCardModuleInfo: item); default: return const SizedBox(); } }
}
