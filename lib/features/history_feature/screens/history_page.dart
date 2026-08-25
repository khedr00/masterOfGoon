import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/features/deals_back/deal_card_info/deal_card_info.dart';
import 'package:untitled1/features/deals_back/get_deal_cards_info.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _cancelToken = CancelToken();
  List<DealCardInfo> _deals = const [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final deals = await getDealCardsInfo(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        cancelToken: _cancelToken,
      );
      if (!mounted) return;
      setState(() {
        _deals = deals.cast<DealCardInfo>().where(_isHistorical).toList();
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  bool _isHistorical(DealCardInfo deal) {
    const statuses = {'COMPLETED', 'REJECTED', 'FAILED'};
    return statuses.contains(deal.dealStage.trim().toUpperCase());
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: width * (30 / 1920)),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(width * (28 / 1920)),
                  child: ButtonWithImage(
                    image: 'assets/images/Slider.png',
                    widthOfButton: width * (60 / 1920),
                    heightOfButton: width * (40 / 1920),
                    heightOfImage: width * (30 / 1920),
                    widthOfImage: width * (30 / 1920),
                  ),
                ),
                ButtonWithImage(
                  image: 'assets/images/Search.png',
                  widthOfButton: width * (60 / 1920),
                  heightOfButton: width * (40 / 1920),
                  heightOfImage: width * (30 / 1920),
                  widthOfImage: width * (30 / 1920),
                ),
              ],
            ),
            SizedBox(
              height: height,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(child: Text(_error!))
                  : _deals.isEmpty
                  ? const Center(child: Text('No completed or rejected deals'))
                  : GridView.builder(
                      padding: EdgeInsets.only(left: width * (15 / 1920)),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3,
                            crossAxisCount: 2,
                          ),
                      itemCount: _deals.length,
                      itemBuilder: (_, index) =>
                          DealCard(dealCardInfo: _deals[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
