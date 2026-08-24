import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/models/property_api_model.dart';
import 'package:untitled1/providers/icon_selector_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';
import 'package:untitled1/features/property_feature/providers/property_data_provider.dart';

class PropertyCardLowerSection extends StatelessWidget {
  const PropertyCardLowerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final allAndDealsOnlyProvider = Provider.of<IconSelectorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final propertyData = context.watch<PropertyDataProvider>();
    final selectedFeature = _selectedFeature(
      propertyData: propertyData,
      fallbackIcon: allAndDealsOnlyProvider.getPageSelected,
      fallbackText: allAndDealsOnlyProvider.gettextSelected,
    );
    final selectedDescription = switch (propertyData.imageContext) {
      PropertyImageContext.room => propertyData.selectedRoom?.summary,
      PropertyImageContext.outdoor => propertyData.selectedOutdoorItem?.summary,
      PropertyImageContext.painting =>
        propertyData.property?.paintingDescription,
      PropertyImageContext.property => propertyData.property?.fullDescription,
    };
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (866 / 1920),
      height: width * (247 / 1920),
      child: Row(
        children: [
          Container(
            width: width * (10 / 1920),
            color: getCardColor(themeProvider.isDarkMode),
          ),
          Container(
            width: width * (856 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? darkFourthColorSecondaryLightBrown
                  : fourthColorSecondaryLightBrown,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: width * (178 / 1920),
                  child: Column(
                    children: [
                      // محل الأيقونة اللي رح تنضغط
                      SizedBox(
                        height: width * (94 / 1920),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width * (50 / 1920),
                              height: width * (50 / 1920),
                              child: Image.asset(selectedFeature.icon),
                            ),
                            Text(
                              selectedFeature.text,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: getPrimaryTextColor(
                                  themeProvider.isDarkMode,
                                ),
                                fontFamily: 'NunitoSans-Regular',
                                fontSize: width * (24 / 1920),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //فيلر
                      Container(
                        height: width * (153 / 1920),
                        decoration: BoxDecoration(
                          color: getCardColor(themeProvider.isDarkMode),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * (10 / 1920)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // هون شرح الأيقونة المكبوسة
                SizedBox(
                  width: width * (675 / 1920),
                  child: _LowerDetailsPanel(
                    propertyData: propertyData,
                    selectedDescription: selectedDescription?.isNotEmpty == true
                        ? selectedDescription!
                        : '',
                    isDarkMode: themeProvider.isDarkMode,
                    width: width,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LowerDetailsPanel extends StatelessWidget {
  const _LowerDetailsPanel({
    required this.propertyData,
    required this.selectedDescription,
    required this.isDarkMode,
    required this.width,
  });

  final PropertyDataProvider propertyData;
  final String selectedDescription;
  final bool isDarkMode;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (propertyData.imageContext == PropertyImageContext.property ||
        propertyData.imageContext == PropertyImageContext.painting) {
      return Center(
        child: _DetailText(
          text: selectedDescription,
          isDarkMode: isDarkMode,
          width: width,
          maxLines: 5,
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: width * (76 / 1920),
          child: _DetailSelectorRow(
            items: _detailItems(propertyData),
            emptyText: propertyData.imageContext == PropertyImageContext.room
                ? 'No room details'
                : 'No outdoor details',
            isDarkMode: isDarkMode,
            width: width,
          ),
        ),
        SizedBox(
          height: width * (171 / 1920),
          child: Center(
            child: _DetailText(
              text: selectedDescription,
              isDarkMode: isDarkMode,
              width: width,
              maxLines: 4,
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailText extends StatelessWidget {
  const _DetailText({
    required this.text,
    required this.isDarkMode,
    required this.width,
    this.maxLines,
  });

  final String text;
  final bool isDarkMode;
  final double width;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: maxLines == null
            ? TextOverflow.visible
            : TextOverflow.ellipsis,
        style: TextStyle(
          color: getPrimaryTextColor(isDarkMode),
          fontFamily: 'NunitoSans-Medium',
          fontSize: width * (28 / 1920),
        ),
      ),
    );
  }
}

class _DetailSelectorRow extends StatelessWidget {
  const _DetailSelectorRow({
    required this.items,
    required this.emptyText,
    required this.isDarkMode,
    required this.width,
  });

  final List<_PropertyDetailItem> items;
  final String emptyText;
  final bool isDarkMode;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: getPrimaryTextColor(isDarkMode),
            fontFamily: 'NunitoSans-SemiBold',
            fontSize: width * (22 / 1920),
          ),
        ),
      );
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: width * (14 / 1920),
        vertical: width * (10 / 1920),
      ),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(width: width * (8 / 1920)),
      itemBuilder: (context, index) {
        final item = items[index];
        return _PropertyDetailChip(
          image: item.image,
          label: item.label,
          isSelected: item.isSelected,
          isDarkMode: isDarkMode,
          width: width,
          onTap: item.onTap,
        );
      },
    );
  }
}

List<_PropertyDetailItem> _detailItems(PropertyDataProvider propertyData) {
  final property = propertyData.property;
  if (property == null) return const [];

  switch (propertyData.imageContext) {
    case PropertyImageContext.room:
      return [
        for (final entry in property.roomItems.asMap().entries)
          _PropertyDetailItem(
            image: 'assets/images/Room.png',
            label: _roomLabel(entry.value, entry.key),
            isSelected: propertyData.selectedRoomId == entry.value.id,
            onTap: () => propertyData.selectRoom(entry.value.id),
          ),
      ];
    case PropertyImageContext.outdoor:
      return [
        for (final entry in property.outdoorItems.asMap().entries)
          _PropertyDetailItem(
            image: _outdoorIcon(entry.value.type),
            label: _outdoorLabel(entry.value, entry.key),
            isSelected: propertyData.selectedOutdoorItemId == entry.value.id,
            onTap: () => propertyData.selectOutdoorItem(entry.value.id),
          ),
      ];
    case PropertyImageContext.painting:
      return const [];
    case PropertyImageContext.property:
      return const [];
  }
}

class _PropertyDetailItem {
  const _PropertyDetailItem({
    required this.image,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String image;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
}

class _PropertyDetailChip extends StatelessWidget {
  const _PropertyDetailChip({
    required this.image,
    required this.label,
    required this.isSelected,
    required this.isDarkMode,
    required this.width,
    required this.onTap,
  });

  final String image;
  final String label;
  final bool isSelected;
  final bool isDarkMode;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final actionColor = isDarkMode
        ? darkFourthColorPrimaryBrown
        : fourthColorPrimaryBrown;
    final radius = BorderRadius.circular(width * (10 / 1920));

    return Semantics(
      button: true,
      selected: isSelected,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          color: Colors.transparent,
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            hoverColor: actionColor.withValues(alpha: 0.08),
            splashColor: actionColor.withValues(alpha: 0.16),
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              constraints: BoxConstraints(
                maxWidth: width * (170 / 1920),
                minHeight: width * (52 / 1920),
              ),
              padding: EdgeInsets.symmetric(horizontal: width * (8 / 1920)),
              decoration: BoxDecoration(
                color: actionColor.withValues(alpha: isSelected ? 0.18 : 0.07),
                border: Border.all(
                  color: actionColor.withValues(alpha: isSelected ? 0.9 : 0.4),
                  width: width * (1.5 / 1920),
                ),
                borderRadius: radius,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: width * (34 / 1920),
                    height: width * (34 / 1920),
                    child: Image.asset(image),
                  ),
                  SizedBox(width: width * (6 / 1920)),
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: actionColor,
                        fontFamily: 'NunitoSans-SemiBold',
                        fontSize: width * (22 / 1920),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_SelectedPropertyFeature _selectedFeature({
  required PropertyDataProvider propertyData,
  required String fallbackIcon,
  required String fallbackText,
}) {
  switch (propertyData.imageContext) {
    case PropertyImageContext.room:
      final room = propertyData.selectedRoom;
      return _SelectedPropertyFeature(
        icon: 'assets/images/Room.png',
        text: room == null
            ? 'Rooms'
            : room.type.isNotEmpty
            ? room.type
            : 'Room',
      );
    case PropertyImageContext.outdoor:
      final outdoor = propertyData.selectedOutdoorItem;
      return _SelectedPropertyFeature(
        icon: _outdoorIcon(outdoor?.type ?? ''),
        text: outdoor == null
            ? 'Outdoors'
            : outdoor.type.isNotEmpty
            ? outdoor.type
            : 'Outdoor',
      );
    case PropertyImageContext.painting:
      return const _SelectedPropertyFeature(
        icon: 'assets/images/Paint Roller.png',
        text: 'Painting',
      );
    case PropertyImageContext.property:
      return _SelectedPropertyFeature(icon: fallbackIcon, text: fallbackText);
  }
}

String _roomLabel(RoomItemApiModel room, int index) {
  return room.type.isNotEmpty ? room.type : 'Room ${index + 1}';
}

String _outdoorLabel(OutdoorItemApiModel outdoor, int index) {
  return outdoor.type.isNotEmpty ? outdoor.type : 'Outdoor ${index + 1}';
}

class _SelectedPropertyFeature {
  const _SelectedPropertyFeature({required this.icon, required this.text});

  final String icon;
  final String text;
}

String _outdoorIcon(String type) {
  final normalizedType = type.toLowerCase();
  if (normalizedType.contains('pool')) return 'assets/images/Pool.png';
  if (normalizedType.contains('balcony')) return 'assets/images/Balcony.png';
  if (normalizedType.contains('garage')) return 'assets/images/Parking.png';
  if (normalizedType.contains('garden')) return 'assets/images/Garden.png';
  return 'assets/images/House With a Garden.png';
}
