import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class PropertyCardLowerSection extends StatelessWidget {
  const PropertyCardLowerSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (866 / 1920),
      height: width * (247 / 1920),
      child: Row(
        children: [
          Container(width: width * (10 / 1920), color: Colors.white),
          Container(
            width: width * (856 / 1920),
            decoration: BoxDecoration(
              color: fourthColorSecondaryLightBrown,
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
                      SizedBox(height: width * (94 / 1920)),
                      //فيلر
                      Container(
                        height: width * (153 / 1920),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * (10 / 1920)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // هون شرح الأيقونة المكبوسة
                SizedBox(width: width * (675 / 1920)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
