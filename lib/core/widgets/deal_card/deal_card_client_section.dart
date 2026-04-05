import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/client_info_inside_deal_card.dart';
import 'package:untitled1/back_end_test/deals/get_client_info_inside_deal_card.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCardClientSection extends StatefulWidget {
  const DealCardClientSection({
    super.key,
    required this.lastMessage,
    required this.timePassed,
    required this.dealId,
  });

  final String lastMessage;
  final String timePassed;

  final int dealId;

  @override
  State<DealCardClientSection> createState() => _DealCardClientSectionState();
}

class _DealCardClientSectionState extends State<DealCardClientSection> {
  ClientInfoInsideDealCard? _clientInfoInsideDealCard;
  final CancelToken _cancelToken = CancelToken();

  void _getClientInfoInsideDealCard() async {
    ClientInfoInsideDealCard clientInfoInsideDealCard =
        await getClientInfoInsideDealCard(
          dealId: widget.dealId,
          cancelToken: _cancelToken,
        );
    if (!mounted) {
      return;
    }
    setState(() {
      _clientInfoInsideDealCard = clientInfoInsideDealCard;
    });
  }

  @override
  void initState() {
    _getClientInfoInsideDealCard();
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
    return Container(
      width: width * (331 / 1920),
      height: width * (194 / 1920),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * (10 / 1920)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: width * (9 / 1920),
          left: width * (9 / 1920),
          right: width * (9 / 1920),
        ),
        child: Container(
          width: width * (331 / 1920),
          height: width * (194 / 1920),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * (10 / 1920)),
              bottomRight: Radius.circular(width * (10 / 1920)),
            ),
          ),
          child: _clientInfoInsideDealCard == null
              ? Container(
                  width: width * (40 / 1920),
                  height: width * (40 / 1920),
                  color: secondaryColor,
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: width * (15 / 1920),
                        left: width * (15 / 1920),
                        bottom: width * (8 / 1920),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * (75 / 1920),
                            height: width * (75 / 1920),
                            child: Image.asset(
                              _clientInfoInsideDealCard!.clientPhoto,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * (20 / 1920),
                              top: width * (5 / 1920),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _clientInfoInsideDealCard!.clientName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NunitoSans-SemiBold',
                                    fontSize: width * (18 / 1920),
                                  ),
                                ),
                                Text(
                                  '${_clientInfoInsideDealCard!.clientLeadScoring.toString()} %',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NunitoSans-SemiBold',
                                    fontSize: width * (18 / 1920),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * (238 / 1920),
                      height: width * (66 / 1920),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          width * (10 / 1920),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.lastMessage,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NunitoSans-SemiBold',
                            fontSize: width * (14 / 1920),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: width * (2 / 1920),
                        left: width * (138 / 1920),
                      ),
                      child: Text(
                        ' ${widget.timePassed} minutes ago',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 53, 53, 53),
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (12 / 1920),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
