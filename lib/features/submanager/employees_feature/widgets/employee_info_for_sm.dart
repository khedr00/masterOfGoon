import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/profile_feature/widgets/profile_card.dart';
import 'package:untitled1/core/profile_feature/widgets/stats_widget.dart/stats_widget.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/features/deal_feature/datasources/change_deal_employee.dart';
import 'package:untitled1/features/deals_back/deal_card_info/deal_card_info.dart';
import 'package:untitled1/features/deals_back/get_deal_cards_info.dart';
import 'package:untitled1/providers/theme_provider.dart';

class EmployeeInfoForSm extends StatefulWidget {
  const EmployeeInfoForSm({
    super.key,
    required this.userAuthInfo,
    required this.employeeId,
  });
  final UserAuthInfo userAuthInfo;
  final String employeeId;

  @override
  State<EmployeeInfoForSm> createState() => _EmployeeInfoForSmState();
}

class _EmployeeInfoForSmState extends State<EmployeeInfoForSm> {
  bool _isDealsChosen = false;
  final _cancelToken = CancelToken();
  List<DealCardInfo> _deals = const [];
  bool _isLoadingDeals = true;
  String? _dealsError;

  @override
  void initState() {
    super.initState();
    _loadDeals();
  }

  Future<void> _loadDeals() async {
    try {
      final deals = await getDealCardsInfo(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        employeeId: widget.employeeId,
        cancelToken: _cancelToken,
      );
      if (!mounted) return;
      setState(() {
        _deals = deals.cast<DealCardInfo>().where(_isOpenDeal).toList();
        _isLoadingDeals = false;
        _dealsError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoadingDeals = false;
        _dealsError = error.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  bool _isOpenDeal(DealCardInfo deal) {
    const closedStatuses = {'COMPLETED', 'REJECTED', 'FAILED'};
    return !closedStatuses.contains(deal.dealStage.trim().toUpperCase());
  }

  Future<void> _reassignDeal(DealCardInfo deal) async {
    final employeeId = await showDialog<String>(
      context: context,
      builder: (_) => const _ReassignDealDialog(),
    );
    if (employeeId == null || employeeId.trim().isEmpty || !mounted) return;

    try {
      final message = await changeDealEmployee(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        dealId: deal.id,
        employeeId: employeeId,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      setState(() => _isLoadingDeals = true);
      await _loadDeals();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString().replaceFirst('Exception: ', ''))),
      );
    }
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (1438 / 1920),
      height: width * (950 / 1920),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(top: width * (43 / 1920)),
            child: ProfileCard(
              userAuthInfo: widget.userAuthInfo,
              employeeId: widget.employeeId,
            ),
          ),
          Container(
            width: width * (5 / 1920),
            height: width * (920 / 1920),
            color: getDividerColor(themeProvider.isDarkMode),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isDealsChosen = false),
                    child: Text(
                      'Stats',
                      style: TextStyle(
                        fontFamily: _isDealsChosen
                            ? 'NunitoSans-Bold'
                            : 'NunitoSans-Black',
                        fontSize: width * (28 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * (30 / 1920)),
                    child: GestureDetector(
                      onTap: () => setState(() => _isDealsChosen = true),
                      child: Text(
                        'Deals',
                        style: TextStyle(
                          fontFamily: !_isDealsChosen
                              ? 'NunitoSans-Bold'
                              : 'NunitoSans-Black',
                          fontSize: width * (28 / 1920),
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _isDealsChosen ? _buildDealsList(context, width, themeProvider) : StatsWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDealsList(BuildContext context, double width, ThemeProvider themeProvider) {
    return Padding(
      padding: EdgeInsets.only(left: width * (28 / 1920)),
      child: SizedBox(
        height: width * (794 / 1920),
        width: width * ((939 + 38) / 1920),
        child: _isLoadingDeals
            ? const Center(child: CircularProgressIndicator())
            : _dealsError != null
            ? Center(child: Text(_dealsError!))
            : _deals.isEmpty
            ? const Center(child: Text('No open deals for this employee'))
            : ListView.builder(
                itemCount: _deals.length,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(bottom: width * (28 / 1920)),
                  child: GestureDetector(
                    onTap: () => _reassignDeal(_deals[index]),
                    child: DealCard(dealCardInfo: _deals[index]),
                  ),
                ),
              ),
      ),
    );
  }
}

class _ReassignDealDialog extends StatefulWidget {
  const _ReassignDealDialog();

  @override
  State<_ReassignDealDialog> createState() => _ReassignDealDialogState();
}

class _ReassignDealDialogState extends State<_ReassignDealDialog> {
  final _employeeIdController = TextEditingController();

  @override
  void dispose() {
    _employeeIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width * (560 / 1920),
        padding: EdgeInsets.all(width * (25 / 1920)),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(width * (15 / 1920)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reassign deal',
              style: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (24 / 1920),
              ),
            ),
            SizedBox(height: width * (20 / 1920)),
            CustomTextField(
              onChanged: (_) {},
              hintText: 'Enter employee ID',
              widthOfTextField: 510,
              fillColor: getInputBackgroundColor(themeProvider.isDarkMode),
              fontSize: 18,
              fontFamily: FontFamily.light,
              controller: _employeeIdController,
              maxLines: 1,
            ),
            SizedBox(height: width * (28 / 1920)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWithText(
                  widthOfButton: width * (130 / 1920),
                  heightOfButton: width * (45 / 1920),
                  text: 'Cancel',
                  buttonAction: () => Navigator.pop(context),
                ),
                ButtonWithText(
                  widthOfButton: width * (130 / 1920),
                  heightOfButton: width * (45 / 1920),
                  text: 'Confirm',
                  buttonAction: () {
                    final employeeId = _employeeIdController.text.trim();
                    if (employeeId.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter an employee ID')),
                      );
                      return;
                    }
                    Navigator.pop(context, employeeId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
