import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee_feature/data_sourses/get_all_complaints.dart';
import 'package:untitled1/features/support_employee_feature/models/complaint_card_info.dart';
import 'package:untitled1/features/support_employee_feature/presentation/complaint_card.dart';
import 'package:untitled1/providers/theme_provider.dart';

enum FilterOption { all, pending, resolved }

class SupportHomePage extends StatefulWidget {
  const SupportHomePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<SupportHomePage> createState() => _SupportHomePageState();
}

class _SupportHomePageState extends State<SupportHomePage> {
  List<ComplaintCardInfo> _complaints = [];
  List<ComplaintCardInfo> _filteredComplaints = [];
  bool _isLoading = false;
  String? _errorMessage;
  FilterOption _currentFilter = FilterOption.all;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  Future<void> _loadComplaints() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      final complaints = await getAllComplaints(dioClient: dioClient);
      setState(() {
        _complaints = complaints;
        _applyFilter();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _applyFilter() {
    switch (_currentFilter) {
      case FilterOption.all:
        _filteredComplaints = _complaints;
        break;
      case FilterOption.pending:
        _filteredComplaints = _complaints
            .where(
              (complaint) =>
                  complaint.complaintStatus.toLowerCase() == 'pending',
            )
            .toList();
        break;
      case FilterOption.resolved:
        _filteredComplaints = _complaints
            .where(
              (complaint) =>
                  complaint.complaintStatus.toLowerCase() == 'resolved',
            )
            .toList();
        break;
    }
  }

  void _selectFilter(FilterOption filter) {
    setState(() {
      _currentFilter = filter;
      _applyFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? darkBackGroundColor
          : backGroundColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          width * (44 / 1920),
          width * (34 / 1920),
          width * (44 / 1920),
          width * (30 / 1920),
        ),
        child: Column(
          children: [
            SizedBox(
              height: width * (68 / 1920),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Complaints',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-ExtraBold',
                        fontSize: width * (34 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  ),
                  _buildFilterBar(width: width),

                  SizedBox(height: width * (28 / 1920)),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: width * (1500 / 1920),
                  child: _buildComplaintsContent(
                    width: width,
                    isDark: themeProvider.isDarkMode,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar({required double width}) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(width * (8 / 1920)),
        decoration: BoxDecoration(
          color: getCardColor(themeProvider.isDarkMode),
          borderRadius: BorderRadius.circular(width * (16 / 1920)),
          border: Border.all(
            color: getBorderColor(themeProvider.isDarkMode),
            width: width * (1 / 1920),
          ),
          boxShadow: [
            BoxShadow(
              color: getShadowColor(
                themeProvider.isDarkMode,
              ).withValues(alpha: .18),
              blurRadius: width * (16 / 1920),
              offset: Offset(0, width * (5 / 1920)),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterButton(
              width: width,
              label: 'All',
              isSelected: _currentFilter == FilterOption.all,
              onTap: () => _selectFilter(FilterOption.all),
            ),
            SizedBox(width: width * (10 / 1920)),
            _buildFilterButton(
              width: width,
              label: 'Pending',
              isSelected: _currentFilter == FilterOption.pending,
              onTap: () => _selectFilter(FilterOption.pending),
            ),
            SizedBox(width: width * (10 / 1920)),
            _buildFilterButton(
              width: width,
              label: 'Resolved',
              isSelected: _currentFilter == FilterOption.resolved,
              onTap: () => _selectFilter(FilterOption.resolved),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintsContent({
    required double width,
    required bool isDark,
  }) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isDark ? darkPrimaryColor : primaryColor,
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading complaints',
              style: TextStyle(
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (22 / 1920),
                color: getPrimaryTextColor(isDark),
              ),
            ),
            SizedBox(height: width * (10 / 1920)),
            SizedBox(
              width: width * (650 / 1920),
              child: Text(
                _errorMessage!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'NunitoSans-Regular',
                  fontSize: width * (15 / 1920),
                  color: getPrimaryTextColor(isDark),
                ),
              ),
            ),
            SizedBox(height: width * (20 / 1920)),
            ElevatedButton(
              onPressed: _loadComplaints,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? darkPrimaryColor : primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: width * (28 / 1920),
                  vertical: width * (14 / 1920),
                ),
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  color: getTextColor(isDark),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (_filteredComplaints.isEmpty) {
      return Center(
        child: Text(
          'No complaints found',
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (22 / 1920),
            color: getPrimaryTextColor(isDark),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: width * (70 / 1920),
        vertical: width * (8 / 1920),
      ),
      itemCount: _filteredComplaints.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: width * (30 / 1920)),
          child: Center(
            child: ComplaintCard(
              complaintCardInfo: _filteredComplaints[index],
              userAuthInfo: widget.userAuthInfo,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterButton({
    required double width,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: width * (150 / 1920),
        height: width * (52 / 1920),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),
        decoration: BoxDecoration(
          color: isSelected
              ? (themeProvider.isDarkMode ? darkPrimaryColor : primaryColor)
              : (themeProvider.isDarkMode
                    ? darkSecondaryColor
                    : secondaryColor),
          borderRadius: BorderRadius.circular(width * (12 / 1920)),
          border: Border.all(
            color: isSelected
                ? (themeProvider.isDarkMode ? darkPrimaryColor : primaryColor)
                : (themeProvider.isDarkMode
                      ? darkBorderColor
                      : lightBorderColor),
            width: width * (2 / 1920),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (18 / 1920),
            color: isSelected
                ? getTextColor(themeProvider.isDarkMode)
                : getPrimaryTextColor(themeProvider.isDarkMode),
          ),
        ),
      ),
    );
  }
}
