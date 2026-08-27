import 'package:flutter/material.dart';
import '../../../core/widgets/constants.dart';
import '../models/conversation.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.conversation,
    required this.isSelected,
    required this.onTap,
    required this.scale,
    required this.rowExtent,
  });

  final Conversation conversation;
  final bool isSelected;
  final VoidCallback onTap;
  final double scale;
  final double rowExtent;

  static const _cardHeight = 91.0;
  static const _borderInset = 20.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? darkSecondaryColor : secondaryColor;
    final canvasColor = isDark ? darkBackGroundColor : backGroundColor;
    final cardWidth = isSelected ? 263.0 : 220.0;
    final wrapperWidth = cardWidth + _borderInset * 2;

    return SizedBox(
      height: rowExtent * scale,
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: (isSelected ? 39 : 0) * scale),
          child: Container(
            width: wrapperWidth * scale,
            height: (_cardHeight + _borderInset * 2) * scale,
            decoration: BoxDecoration(
              color: canvasColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20 * scale),
                bottomRight: Radius.circular(20 * scale),
              ),
            ),
            // The selected state is deliberately layered: the blue tile sits
            // over the gray hook rather than being laid out beside it.
            child: isSelected
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: _borderInset * scale,
                        // Overlap the gray hook by one inset. The blue layer
                        // now reaches the chat-side connector while the final
                        // gray inset keeps ownership of the reverse curve.
                        width: (cardWidth + _borderInset) * scale,
                        height: _cardHeight * scale,
                        child: _buildContactCard(
                          context,
                          isDark: isDark,
                          surfaceColor: surfaceColor,
                          selected: true,
                        ),
                      ),
                      Positioned(
                        top: (20) * scale,
                        right: 0,
                        child: Container(
                          color: surfaceColor,
                          width: 20 * scale,
                          height: _cardHeight * scale,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          color: surfaceColor,
                          width: 20 * scale,
                          height: 20 * scale,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: canvasColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50 * scale),
                            ),
                          ),
                          width: 20 * scale,
                          height: 20 * scale,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          color: surfaceColor,
                          width: 20 * scale,
                          height: 20 * scale,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: canvasColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50 * scale),
                            ),
                          ),
                          width: 20 * scale,
                          height: 20 * scale,
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.all(_borderInset * scale),
                    child: _buildContactCard(
                      context,
                      isDark: isDark,
                      surfaceColor: surfaceColor,
                      selected: false,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required bool isDark,
    required Color surfaceColor,
    required bool selected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: selected
            ? BorderRadius.zero
            : BorderRadius.only(
                topRight: Radius.circular(20 * scale),
                bottomRight: Radius.circular(20 * scale),
              ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18 * scale),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: selected
                ? BorderRadius.zero
                : BorderRadius.only(
                    topRight: Radius.circular(20 * scale),
                    bottomRight: Radius.circular(20 * scale),
                  ),
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 52 * scale,
                    height: 52 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getCardColor(isDark),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        conversation.user.avatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: 26 * scale,
                          color: getSecondaryTextColor(isDark),
                        ),
                      ),
                    ),
                  ),
                  if (conversation.user.isActive)
                    Positioned(
                      right: -1 * scale,
                      bottom: -1 * scale,
                      child: Container(
                        width: 14 * scale,
                        height: 14 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkFifthColorPrimaryGreen,
                          border: Border.all(
                            color: surfaceColor,
                            width: 2 * scale,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.bold,
                        color: getPrimaryTextColor(isDark),
                      ),
                    ),
                    SizedBox(height: 6 * scale),
                    Text(
                      conversation.lastMessage?.text ?? 'No messages',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 12 * scale,
                        color: getSecondaryTextColor(isDark),
                      ),
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
}
