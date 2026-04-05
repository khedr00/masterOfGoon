import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/get_deal_t_notes_info.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/get_single_deal_schedule_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_notes_widget.dart';

class DealsOnlyScheduleWidget extends StatefulWidget {
  const DealsOnlyScheduleWidget({
    super.key,
    required this.forDealPage,
    required this.dealId,
  });
  final int dealId;
  final bool forDealPage;

  @override
  State<DealsOnlyScheduleWidget> createState() =>
      _DealsOnlyScheduleWidgetState();
}

class _DealsOnlyScheduleWidgetState extends State<DealsOnlyScheduleWidget> {
  final List<DealsNotesWidget> _apoitmentsNotes = [];
  final List<String> _dealTNotes = [];
  final CancelToken _cancelToken = CancelToken();
  void _getSingleDealSheduleInfo() async {
    List<DealsNotesWidget> apoitmentsNotes = await getSingleDealScheduleInfo(
      dealId: widget.dealId,
      cancelToken: _cancelToken,
    );
    List<String> dealTNotes = await getDealTNotesInfo(
      dealId: widget.dealId,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _apoitmentsNotes.addAll(apoitmentsNotes);
      _dealTNotes.addAll(dealTNotes);
    });
  }

  @override
  void initState() {
    _getSingleDealSheduleInfo();
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
    if (_apoitmentsNotes.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    List<Widget> dealsNotes = [];
    List<Widget> apoitmentsNotesWithPaddings = [];
    for (int i = 0; i < _dealTNotes.length; i++) {
      dealsNotes.add(
        Padding(
          padding: EdgeInsets.all(width * (10 / 1920)),
          child: Text(
            '${(i + 1).toString()}_${_dealTNotes[i]}',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NunitoSans-Bold',
              fontSize: width * (24 / 1920),
            ),
          ),
        ),
      );
    }
    for (int i = 0; i < _apoitmentsNotes.length; i++) {
      apoitmentsNotesWithPaddings.add(
        Padding(
          padding: EdgeInsetsGeometry.only(top: width * (60 / 1920)),
          child: _apoitmentsNotes[i],
        ),
      );
    }

    return Container(
      width: width * (895 / 1920),
      height: width * (827 / 1920),
      decoration: widget.forDealPage
          ? BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (30 / 1920)),
                bottomLeft: Radius.circular(width * (30 / 1920)),
                bottomRight: Radius.circular(width * (30 / 1920)),
              ),
            )
          : BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
              border: Border.all(
                color: thirdColorPrimary,
                width: width * (4 / 1920),
              ),
            ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width * (895 / 1920),
              // height: width * (177 / 1920),
              decoration: BoxDecoration(
                color: thirdColorPrimary,
                borderRadius: widget.forDealPage
                    ? BorderRadius.only(
                        topRight: Radius.circular(width * (30 / 1920)),
                      )
                    : BorderRadius.circular(1),
              ),
              child: Column(children: dealsNotes),
            ),
            Column(children: apoitmentsNotesWithPaddings),
          ],
        ),
      ),
    );
  }
}
