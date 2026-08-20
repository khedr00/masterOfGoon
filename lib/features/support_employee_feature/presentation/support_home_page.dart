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
    setState(() {
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
      body: Column(
        children: [
          // Filter Header
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * (40 / 1920),
                vertical: width * (20 / 1920),
              ),
              child: Row(
                children: [
                  _buildFilterButton(
                    width: width,
                    label: 'All',
                    isSelected: _currentFilter == FilterOption.all,
                    onTap: () {
                      setState(() {
                        _currentFilter = FilterOption.all;
                        _applyFilter();
                      });
                    },
                  ),
                  SizedBox(width: width * (15 / 1920)),
                  _buildFilterButton(
                    width: width,
                    label: 'Pending',
                    isSelected: _currentFilter == FilterOption.pending,
                    onTap: () {
                      setState(() {
                        _currentFilter = FilterOption.pending;
                        _applyFilter();
                      });
                    },
                  ),
                  SizedBox(width: width * (15 / 1920)),
                  _buildFilterButton(
                    width: width,
                    label: 'Resolved',
                    isSelected: _currentFilter == FilterOption.resolved,
                    onTap: () {
                      setState(() {
                        _currentFilter = FilterOption.resolved;
                        _applyFilter();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        themeProvider.isDarkMode
                            ? darkPrimaryColor
                            : primaryColor,
                      ),
                    ),
                  )
                : _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error loading complaints',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (18 / 1920),
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                          ),
                        ),
                        SizedBox(height: width * (10 / 1920)),
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Regular',
                            fontSize: width * (14 / 1920),
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                          ),
                        ),
                        SizedBox(height: width * (20 / 1920)),
                        ElevatedButton(
                          onPressed: _loadComplaints,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeProvider.isDarkMode
                                ? darkPrimaryColor
                                : primaryColor,
                          ),
                          child: Text(
                            'Retry',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              color: getTextColor(themeProvider.isDarkMode),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : _filteredComplaints.isEmpty
                ? Center(
                    child: Text(
                      'No complaints found',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (18 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * (40 / 1920),
                      vertical: width * (10 / 1920),
                    ),
                    child: ListView.builder(
                      itemCount: _filteredComplaints.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: width * (20 / 1920)),
                          child: ComplaintCard(
                            complaintCardInfo: _filteredComplaints[index],
                            userAuthInfo: widget.userAuthInfo,
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
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
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * (20 / 1920),
          vertical: width * (10 / 1920),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (themeProvider.isDarkMode ? darkPrimaryColor : primaryColor)
              : (themeProvider.isDarkMode
                    ? darkSecondaryColor
                    : secondaryColor),
          borderRadius: BorderRadius.circular(width * (8 / 1920)),
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
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (16 / 1920),
            color: isSelected
                ? getTextColor(themeProvider.isDarkMode)
                : getPrimaryTextColor(themeProvider.isDarkMode),
          ),
        ),
      ),
    );
  }
}
