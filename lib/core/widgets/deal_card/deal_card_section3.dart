import 'package:flutter/material.dart';

class DealCardSection3 extends StatelessWidget {
  const DealCardSection3({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            // فيلير لمحل الستاك مشان ما تجي فيه عناصر و تختفي تحت الستاك
            Container(
              width: width * (413 / 1920),
              height: width * (79 / 1920),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
