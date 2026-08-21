import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee_feature/data_sourses/get_complaint_by_id.dart';
import 'package:untitled1/features/support_employee_feature/data_sourses/reply_complaint.dart';
import 'package:untitled1/features/support_employee_feature/data_sourses/resolve_complaint.dart';
import 'package:untitled1/features/support_employee_feature/models/complaint_card_info.dart';
import 'package:untitled1/features/support_employee_feature/models/complaint_info.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ComplaintCard extends StatefulWidget {
  const ComplaintCard({
    super.key,
    required this.complaintCardInfo,
    required this.userAuthInfo,
  });

  final ComplaintCardInfo complaintCardInfo;
  final UserAuthInfo userAuthInfo;

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  bool _isExpanded = false;
  ComplaintInfo? _complaintInfo;
  bool _isLoadingDetails = false;
  bool _isSubmittingReply = false;
  bool _isResolving = false;
  final TextEditingController _replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadComplaintDetails();
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Future<void> _loadComplaintDetails() async {
    if (_complaintInfo != null) {
      return;
    }

    setState(() {
      _isLoadingDetails = true;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      final details = await getComplaintById(
        dioClient: dioClient,
        complaintId: widget.complaintCardInfo.complaintId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _complaintInfo = details;
        _isLoadingDetails = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoadingDetails = false;
      });
    }
  }

  Future<void> _submitReply() async {
    if (_replyController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _isSubmittingReply = true;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      await replyComplaint(
        dioClient: dioClient,
        complaintId: widget.complaintCardInfo.complaintId,
        replyMessage: _replyController.text.trim(),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmittingReply = false;
        _replyController.clear();
      });
      _showSnackBar('Reply sent successfully');
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmittingReply = false;
      });
      _showSnackBar('Failed to send reply: $e');
    }
  }

  Future<void> _markAsResolved() async {
    setState(() {
      _isResolving = true;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      await resolveComplaint(
        dioClient: dioClient,
        complaintId: widget.complaintCardInfo.complaintId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isResolving = false;
      });
      _showSnackBar('Complaint marked as resolved');
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isResolving = false;
      });
      _showSnackBar('Failed to resolve complaint: $e');
    }
  }

  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return isoDate;
    }
  }

  String _issuePreview() {
    if (_isLoadingDetails) {
      return 'Loading complaint details...';
    }

    final issueMessage = _complaintInfo?.issueMessage.trim() ?? '';
    if (issueMessage.isEmpty) {
      return 'Failed to load complaint details';
    }

    return issueMessage;
  }

  Color _statusColor(bool isDark) {
    switch (widget.complaintCardInfo.complaintStatus.toLowerCase()) {
      case 'resolved':
      case 'closed':
        return isDark ? darkFifthColorPrimaryGreen : fifthColorPrimaryGreen;
      case 'rejected':
      case 'critical':
        return isDark ? darkSixthColorPrimaryRed : sixthColorPrimaryRed;
      default:
        return isDark ? darkFourthColorPrimaryBrown : fourthColorPrimaryBrown;
    }
  }

  Color _severityColor(bool isDark) {
    switch (widget.complaintCardInfo.severity.toLowerCase()) {
      case 'critical':
      case 'high':
        return isDark ? darkSixthColorPrimaryRed : sixthColorPrimaryRed;
      case 'medium':
        return isDark ? darkFourthColorPrimaryBrown : fourthColorPrimaryBrown;
      default:
        return isDark ? darkFifthColorPrimaryGreen : fifthColorPrimaryGreen;
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final cardHeight = _isExpanded
        ? width * (418 / 1920)
        : width * (246 / 1920);

    return Stack(
      children: [
        Container(
          width: width * (1100 / 1920),
          height: cardHeight,
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? darkSecondaryColor
                : secondaryColor,
            borderRadius: BorderRadius.circular(width * (10 / 1920)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusStageSection(width, themeProvider.isDarkMode),
                  _userSection(
                    width,
                    cardHeight: cardHeight,
                    isDark: themeProvider.isDarkMode,
                  ),
                ],
              ),
              _complaintDetailsSection(
                width,
                cardHeight: cardHeight,
                isDark: themeProvider.isDarkMode,
              ),
            ],
          ),
        ),
        Positioned(
          left: width * (136 / 1920),
          top: 0,
          width: width * (608 / 1920),
          height: width * (80 / 1920),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * (10 / 1920)),
                bottomRight: Radius.circular(width * (10 / 1920)),
              ),
              color: themeProvider.isDarkMode
                  ? darkBackGroundColor
                  : backGroundColor,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (9 / 1920),
                    top: width * (9 / 1920),
                    bottom: width * (9 / 1920),
                  ),
                  child: Container(
                    width: width * (452 / 1920),
                    height: width * (62 / 1920),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? darkSecondaryColor
                          : secondaryColor,
                      borderRadius: BorderRadius.circular(width * (10 / 1920)),
                    ),
                    child: Center(
                      child: Text(
                        widget.complaintCardInfo.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (9 / 1920),
                    right: width * (9 / 1920),
                    bottom: width * (9 / 1920),
                  ),
                  child: Container(
                    width: width * (129 / 1920),
                    height: width * (71 / 1920),
                    decoration: BoxDecoration(
                      color: _severityColor(themeProvider.isDarkMode),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(width * (10 / 1920)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Severity:\n${widget.complaintCardInfo.severity.toUpperCase()}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: getTextColor(themeProvider.isDarkMode),
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: width * (14 / 1920),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusStageSection(double width, bool isDark) {
    return Row(
      children: [
        Container(
          width: width * (136 / 1920),
          height: width * (52 / 1920),
          decoration: BoxDecoration(
            color: isDark ? darkBackGroundColor : backGroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * (10 / 1920)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: width * (9 / 1920)),
            child: Container(
              width: width * (136 / 1920),
              height: width * (43 / 1920),
              decoration: BoxDecoration(
                color: _statusColor(isDark),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * (10 / 1920)),
                ),
              ),
              child: Center(
                child: Text(
                  widget.complaintCardInfo.complaintStatus.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: getTextColor(isDark),
                    fontFamily: 'NunitoSans-ExtraBold',
                    fontSize: width * (15 / 1920),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _userSection(
    double width, {
    required double cardHeight,
    required bool isDark,
  }) {
    return Container(
      width: width * (331 / 1920),
      height: cardHeight - width * (52 / 1920),
      decoration: BoxDecoration(
        color: isDark ? darkBackGroundColor : backGroundColor,
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
          decoration: BoxDecoration(
            color: isDark ? darkSecondaryColor : secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * (10 / 1920)),
              bottomRight: Radius.circular(width * (10 / 1920)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(width * (15 / 1920)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _avatar(width, isDark),
                    SizedBox(width: width * (16 / 1920)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.complaintCardInfo.userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: getPrimaryTextColor(isDark),
                              fontFamily: 'NunitoSans-SemiBold',
                              fontSize: width * (18 / 1920),
                            ),
                          ),
                          SizedBox(height: width * (4 / 1920)),
                          Text(
                            widget.complaintCardInfo.userRole.toLowerCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: getSecondaryTextColor(isDark),
                              fontFamily: 'NunitoSans-SemiBold',
                              fontSize: width * (13 / 1920),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width * (8 / 1920)),
                Container(
                  width: width * (238 / 1920),
                  height: width * (56 / 1920),
                  decoration: BoxDecoration(
                    color: getCardColor(isDark),
                    borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * (12 / 1920),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _contactLine(
                          width,
                          isDark: isDark,
                          icon: Icons.email_outlined,
                          text: _complaintInfo?.email ?? 'Loading email...',
                        ),
                        SizedBox(height: width * (6 / 1920)),
                        _contactLine(
                          width,
                          isDark: isDark,
                          icon: Icons.phone_outlined,
                          text:
                              _complaintInfo?.phoneNumber ?? 'Loading phone...',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: width * (3 / 1920)),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Code: ${widget.complaintCardInfo.code}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: getSecondaryTextColor(isDark),
                      fontFamily: 'NunitoSans-SemiBold',
                      fontSize: width * (12 / 1920),
                    ),
                  ),
                ),
                if (_isExpanded) ...[const Spacer(), _roleChip(width, isDark)],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _complaintDetailsSection(
    double width, {
    required double cardHeight,
    required bool isDark,
  }) {
    return SizedBox(
      width: width * (608 / 1920),
      height: cardHeight,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width * (413 / 1920),
                height: width * (79 / 1920),
                decoration: BoxDecoration(
                  color: isDark ? darkSecondaryColor : secondaryColor,
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
                      _formatDate(widget.complaintCardInfo.createdAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: getPrimaryTextColor(isDark),
                        fontFamily: 'NunitoSans-MediumItalic',
                        fontSize: width * (14 / 1920),
                      ),
                    ),
                    Text(
                      'ID : ${widget.complaintCardInfo.complaintId}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: getPrimaryTextColor(isDark),
                        fontFamily: 'NunitoSans-MediumItalic',
                        fontSize: width * (14 / 1920),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * (608 / 1920),
            height: cardHeight - width * (79 / 1920),
            child: _isExpanded
                ? _expandedDetails(width, isDark)
                : _collapsedDetails(width, isDark),
          ),
        ],
      ),
    );
  }

  Widget _collapsedDetails(double width, bool isDark) {
    return Row(
      children: [
        Container(
          width: width * (305 / 1920),
          height: width * (153 / 1920),
          padding: EdgeInsets.all(width * (16 / 1920)),
          child: Container(
            decoration: BoxDecoration(
              color: getCardColor(isDark),
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Center(
              child: _isLoadingDetails
                  ? SizedBox(
                      width: width * (26 / 1920),
                      height: width * (26 / 1920),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? darkPrimaryColor : primaryColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(width * (14 / 1920)),
                      child: Text(
                        _issuePreview(),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: getPrimaryTextColor(isDark),
                          fontFamily: 'NunitoSans-Medium',
                          fontSize: width * (15 / 1920),
                        ),
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(
          width: width * (303 / 1920),
          height: width * (153 / 1920),
          child: Padding(
            padding: EdgeInsets.only(
              top: width * (15 / 1920),
              right: width * (20 / 1920),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailLine(
                  width,
                  isDark: isDark,
                  icon: Icons.report_problem_outlined,
                  text: widget.complaintCardInfo.name,
                ),
                SizedBox(height: width * (12 / 1920)),
                _detailLine(
                  width,
                  isDark: isDark,
                  icon: Icons.verified_outlined,
                  text: widget.complaintCardInfo.complaintStatus,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: _expandButton(width, isDark),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _expandedDetails(double width, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * (16 / 1920),
        right: width * (20 / 1920),
        bottom: width * (16 / 1920),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * (14 / 1920)),
              decoration: BoxDecoration(
                color: getCardColor(isDark),
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
              ),
              child: _isLoadingDetails
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? darkPrimaryColor : primaryColor,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        _issuePreview(),
                        style: TextStyle(
                          color: getPrimaryTextColor(isDark),
                          fontFamily: 'NunitoSans-Medium',
                          fontSize: width * (15 / 1920),
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(height: width * (12 / 1920)),
          SizedBox(
            height: width * (78 / 1920),
            child: TextField(
              controller: _replyController,
              maxLines: 3,
              style: TextStyle(
                fontSize: width * (14 / 1920),
                fontFamily: 'NunitoSans-Light',
                color: getPrimaryTextColor(isDark),
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: width * (12 / 1920),
                  horizontal: width * (14 / 1920),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Write your reply...',
                hintStyle: TextStyle(
                  fontSize: width * (14 / 1920),
                  color: getHintTextColor(isDark),
                  fontFamily: 'NunitoSans-Light',
                ),
                filled: true,
                fillColor: getInputBackgroundColor(isDark),
              ),
            ),
          ),
          SizedBox(height: width * (12 / 1920)),
          Row(
            children: [
              Button(
                buttonAction: _isSubmittingReply ? null : _submitReply,
                widthOfButton: width * (145 / 1920),
                heightOfButton: width * (42 / 1920),
                borderRadiusOfButton: width * (10 / 1920),
                child: _isSubmittingReply
                    ? _buttonLoader(width, isDark)
                    : Text(
                        'Send Reply',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (14 / 1920),
                          color: getTextColor(isDark),
                        ),
                      ),
              ),
              SizedBox(width: width * (12 / 1920)),
              Button(
                buttonAction: _isResolving ? null : _markAsResolved,
                widthOfButton: width * (175 / 1920),
                heightOfButton: width * (42 / 1920),
                borderRadiusOfButton: width * (10 / 1920),
                child: _isResolving
                    ? _buttonLoader(width, isDark)
                    : Text(
                        'Mark Resolved',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (14 / 1920),
                          color: getTextColor(isDark),
                        ),
                      ),
              ),
              const Spacer(),
              _expandButton(width, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _avatar(double width, bool isDark) {
    final photo = widget.complaintCardInfo.userPhoto;

    return SizedBox(
      width: width * (60 / 1920),
      height: width * (60 / 1920),
      child: CircleAvatar(
        backgroundColor: getCardColor(isDark),
        backgroundImage: photo.isNotEmpty ? NetworkImage(photo) : null,
        child: photo.isEmpty
            ? Icon(
                Icons.person,
                size: width * (30 / 1920),
                color: getPrimaryTextColor(isDark),
              )
            : null,
      ),
    );
  }

  Widget _contactLine(
    double width, {
    required bool isDark,
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: width * (15 / 1920),
          color: getSecondaryTextColor(isDark),
        ),
        SizedBox(width: width * (7 / 1920)),
        Expanded(
          child: Text(
            text.isEmpty ? '-' : text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: getPrimaryTextColor(isDark),
              fontFamily: 'NunitoSans-SemiBold',
              fontSize: width * (12 / 1920),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailLine(
    double width, {
    required bool isDark,
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: width * (25 / 1920),
          color: getPrimaryTextColor(isDark),
        ),
        SizedBox(width: width * (9 / 1920)),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: getPrimaryTextColor(isDark),
              fontFamily: 'NunitoSans-SemiBold',
              fontSize: width * (16 / 1920),
            ),
          ),
        ),
      ],
    );
  }

  Widget _roleChip(double width, bool isDark) {
    return Container(
      width: double.infinity,
      height: width * (38 / 1920),
      decoration: BoxDecoration(
        color: getCardColor(isDark),
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: Center(
        child: Text(
          'Submitted by ${widget.complaintCardInfo.userRole.toLowerCase()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: getPrimaryTextColor(isDark),
            fontFamily: 'NunitoSans-SemiBold',
            fontSize: width * (13 / 1920),
          ),
        ),
      ),
    );
  }

  Widget _expandButton(double width, bool isDark) {
    return InkWell(
      onTap: _toggleExpanded,
      borderRadius: BorderRadius.circular(width * (10 / 1920)),
      child: Container(
        height: width * (38 / 1920),
        padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),
        decoration: BoxDecoration(
          color: isDark ? darkBackGroundColor : backGroundColor,
          borderRadius: BorderRadius.circular(width * (10 / 1920)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isExpanded ? 'Collapse' : 'Details',
              style: TextStyle(
                color: getPrimaryTextColor(isDark),
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (13 / 1920),
              ),
            ),
            SizedBox(width: width * (6 / 1920)),
            Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              size: width * (18 / 1920),
              color: getPrimaryTextColor(isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonLoader(double width, bool isDark) {
    return SizedBox(
      width: width * (22 / 1920),
      height: width * (22 / 1920),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(getTextColor(isDark)),
      ),
    );
  }
}
