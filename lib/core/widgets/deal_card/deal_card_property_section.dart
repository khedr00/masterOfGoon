import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/property_info_inside_deal_card.dart';
import 'package:untitled1/back_end_test/deals/get_property_info_inside_deal_card.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCardPropertySection extends StatefulWidget {
  const DealCardPropertySection({
    super.key,
    required this.dealDate,
    required this.propertyId,
    required this.dealId,
  });
  final String dealDate;
  final String dealId;
  final int propertyId;

  @override
  State<DealCardPropertySection> createState() =>
      _DealCardPropertySectionState();
}

class _DealCardPropertySectionState extends State<DealCardPropertySection> {
  PropertyInfoInsideDealCard? _propertyInfoInsideDealCard;
  final CancelToken _cancelToken = CancelToken();
  void _getPropertyInfoInsideDealCard() async {
    PropertyInfoInsideDealCard propertyInfoInsideDealCard =
        await getPropertyInfoInsideDealCard(propertyId: widget.propertyId);

    if (!mounted) {
      return;
    }
    setState(() {
      _propertyInfoInsideDealCard = propertyInfoInsideDealCard;
    });
  }

  @override
  void initState() {
    _getPropertyInfoInsideDealCard();
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (_propertyInfoInsideDealCard == null) {
      return Container(
        width: width * (550 / 1920),
        color: secondaryColor,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      children: [
        Row(
          children: [
            // فيلير لمحل الستاك مشان ما تجي فيه عناصر و تختفي تحت الستاك
            Container(
              width: width * (413 / 1920),
              height: width * (79 / 1920),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
              ),
            ),
            SizedBox(
              width: width * (193 / 1920),
              height: width * (79 / 1920),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.dealDate,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-MediumItalic',
                      fontSize: width * (16 / 1920),
                    ),
                  ),
                  Text(
                    'ID : ${widget.dealId}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-MediumItalic',
                      fontSize: width * (16 / 1920),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * (305 / 1920),
              height: width * (153 / 1920),
              child: Image.asset(
                _propertyInfoInsideDealCard!.propertyPrimaryImage,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                // top: width * (10 / 1920),
                // left: width * (10 / 1920),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * (40 / 1920),
                        height: width * (40 / 1920),
                        child: Image.asset(
                          'assets/images/House With a Garden.png',
                        ),
                      ),
                      Text(
                        _propertyInfoInsideDealCard!.propertyType,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * (35 / 1920)),
                        child: SizedBox(
                          width: width * (40 / 1920),
                          height: width * (40 / 1920),
                          child: Image.asset('assets/images/Price Tag USD.png'),
                        ),
                      ),
                      Text(
                        '${_propertyInfoInsideDealCard!.propertyPrice.toString()} \$',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: width * (10 / 1920),
                      left: width * (20 / 1920),
                    ),
                    child: SizedBox(
                      width: width * (272 / 1920),
                      height: width * (70 / 1920),
                      child: SizedBox(
                        width: width * (256 / 1902),
                        height: width * (60 / 1920),
                        child: Text(
                          _propertyInfoInsideDealCard!
                              .propertySimpleDescription,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Medium',
                            fontSize: width * (18 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * (25 / 1920),
                        height: width * (25 / 1920),
                        child: Image.asset('assets/images/Location.png'),
                      ),
                      Text(
                        _propertyInfoInsideDealCard!.propertyAddress,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (13 / 1920),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
