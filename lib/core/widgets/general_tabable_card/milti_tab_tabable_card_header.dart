import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class MultiTabTabableCardHeader extends StatefulWidget {
  const MultiTabTabableCardHeader({
    super.key,
    required this.tabName,
    required this.isTabed,
    required this.color,
    required this.index,
    required this.trueTabed,
  });
  final String tabName;
  final ThemeColor color;
  final bool isTabed;
  final int index;
  final List<bool> trueTabed;

  @override
  State<MultiTabTabableCardHeader> createState() =>
      _MultiTabTabableCardHeaderState();
}

class _MultiTabTabableCardHeaderState extends State<MultiTabTabableCardHeader> {
  @override
  Widget build(BuildContext context) {
    int tabedIndex = 0;
    for (int i = 0; i < widget.trueTabed.length; i++) {
      if (widget.trueTabed[i]) {
        tabedIndex = i;
      }
    }
    double width = MediaQuery.of(context).size.width;
    if (widget.index == 0) {
      return Container(
        height: width * (52 / 1920),
        width: width * (179 / 1920),
        decoration: BoxDecoration(
          color: widget.color.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * (10 / 1920)),
            bottomRight: Radius.circular(width * (30 / 1920)),
          ),
        ),
        child: widget.isTabed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * (121 / 1920),
                    child: Center(
                      child: Text(
                        widget.tabName,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (20 / 1920),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  widget.tabName,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                  ),
                ),
              ),
      );
    }
    if (widget.index == -1) {
      return Container(
        height: width * (52 / 1920),
        width: width * (179 / 1920),
        decoration: BoxDecoration(
          color: widget.color.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(width * (10 / 1920)),
            bottomLeft: Radius.circular(width * (30 / 1920)),
          ),
        ),
        child: widget.isTabed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * (121 / 1920),
                    child: Center(
                      child: Text(
                        widget.tabName,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (20 / 1920),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  widget.tabName,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                  ),
                ),
              ),
      );
    }
    return Container(
      height: width * (52 / 1920),
      width: width * (207 / 1920),
      decoration: BoxDecoration(
        color: widget.color.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * (30 / 1920)),
          bottomRight: Radius.circular(width * (30 / 1920)),
        ),
      ),
      child: !widget.isTabed
          ? Row(
              mainAxisAlignment: tabedIndex > widget.index
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * (151 / 1920),
                  child: Center(
                    child: Text(
                      widget.tabName,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                widget.tabName,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (20 / 1920),
                ),
              ),
            ),
    );
  }
}
