import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/icon_selector_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class TabablePropertyIcon extends StatelessWidget {
  const TabablePropertyIcon({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
    this.showClickableState = false,
  });
  final String image;
  final String text;
  final VoidCallback? onTap;
  final bool showClickableState;

  @override
  Widget build(BuildContext context) {
    final allAndDealsOnlyProvider = Provider.of<IconSelectorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    final isSelected =
        allAndDealsOnlyProvider.getPageSelected == image &&
        allAndDealsOnlyProvider.gettextSelected == text;
    final actionColor = themeProvider.isDarkMode
        ? darkFourthColorPrimaryBrown
        : fourthColorPrimaryBrown;
    final borderRadius = BorderRadius.circular(width * (12 / 1920));
    final horizontalPadding = showClickableState ? width * (6 / 1920) : 0.0;
    final iconSize = width * (showClickableState ? 42 / 1920 : 60 / 1920);
    final textGap = width * (showClickableState ? 6 / 1920 : 10 / 1920);
    final fontSize = width * (showClickableState ? 24 / 1920 : 32 / 1920);

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      height: width * (60 / 1920),
      constraints: showClickableState
          ? BoxConstraints(maxWidth: width * (185 / 1920))
          : null,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: showClickableState
          ? BoxDecoration(
              color: actionColor.withValues(alpha: isSelected ? 0.16 : 0.08),
              border: Border.all(
                color: actionColor.withValues(alpha: isSelected ? 0.9 : 0.45),
                width: width * (1.5 / 1920),
              ),
              borderRadius: borderRadius,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: actionColor.withValues(alpha: 0.18),
                        blurRadius: width * (8 / 1920),
                        offset: Offset(0, width * (2 / 1920)),
                      ),
                    ]
                  : null,
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: textGap),
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: Image.asset(image),
            ),
          ),
          if (showClickableState)
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: actionColor,
                  fontFamily: 'NunitoSans-SemiBold',
                  fontSize: fontSize,
                ),
              ),
            )
          else
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Regular',
                fontSize: fontSize,
              ),
            ),
          if (showClickableState)
            Padding(
              padding: EdgeInsets.only(left: width * (4 / 1920)),
              child: Icon(
                Icons.chevron_right_rounded,
                color: actionColor,
                size: width * (18 / 1920),
              ),
            ),
        ],
      ),
    );

    if (!showClickableState) return content;

    return Semantics(
      button: true,
      selected: isSelected,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            hoverColor: actionColor.withValues(alpha: 0.08),
            splashColor: actionColor.withValues(alpha: 0.16),
            onTap: () {
              allAndDealsOnlyProvider.selectIcon(image);
              allAndDealsOnlyProvider.selectText(text);
              onTap?.call();
            },
            child: content,
          ),
        ),
      ),
    );
  }
}
