import 'package:flutter/material.dart';
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
import 'package:intl/intl.dart';

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

  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return isoDate;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadComplaintDetails();
  }

  Future<void> _loadComplaintDetails() async {
    if (_complaintInfo != null) return;
    
    setState(() {
      _isLoadingDetails = true;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      final details = await getComplaintById(
        dioClient: dioClient,
        complaintId: widget.complaintCardInfo.complaintId,
      );
      if (mounted) {
        setState(() {
          _complaintInfo = details;
          _isLoadingDetails = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingDetails = false;
        });
      }
    }
  }

  Future<void> _submitReply() async {
    if (_replyController.text.trim().isEmpty) return;

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
      if (mounted) {
        setState(() {
          _isSubmittingReply = false;
          _replyController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reply sent successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmittingReply = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send reply: $e')),
        );
      }
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
      if (mounted) {
        setState(() {
          _isResolving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint marked as resolved')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isResolving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resolve complaint: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * (900 / 1920),
      height: _isExpanded ? width * (600 / 1920) : width * (420 / 1920),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: width * (880 / 1920),
              height: _isExpanded ? width * (580 / 1920) : width * (400 / 1920),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? darkSecondaryColor
                    : secondaryColor,
                borderRadius: BorderRadius.circular(width * (12 / 1920)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Left Column - User Info
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width * (250 / 1920),
                        height: _isExpanded ? width * (580 / 1920) : width * (400 / 1920),
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? darkSecondaryColor
                              : secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * (12 / 1920)),
                            bottomLeft: Radius.circular(width * (12 / 1920)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Client tag
                            Padding(
                              padding: EdgeInsets.only(
                                top: width * (12 / 1920),
                                left: width * (12 / 1920),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * (10 / 1920),
                                  vertical: width * (6 / 1920),
                                ),
                                decoration: BoxDecoration(
                                  color: themeProvider.isDarkMode
                                      ? darkPrimaryColor
                                      : primaryColor,
                                  borderRadius: BorderRadius.circular(width * (6 / 1920)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: width * (16 / 1920),
                                      color: getTextColor(themeProvider.isDarkMode),
                                    ),
                                    SizedBox(width: width * (6 / 1920)),
                                    Text(
                                      widget.complaintCardInfo.userRole.toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans-Bold',
                                        fontSize: width * (14 / 1920),
                                        color: getTextColor(themeProvider.isDarkMode),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Profile photo
                            SizedBox(
                              height: width * (80 / 1920),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: width * (15 / 1920),
                                  left: width * (25 / 1920),
                                ),
                                child: SizedBox(
                                  width: width * (80 / 1920),
                                  height: width * (80 / 1920),
                                  child: CircleAvatar(
                                    backgroundImage: widget.complaintCardInfo.userPhoto.isNotEmpty
                                        ? NetworkImage(widget.complaintCardInfo.userPhoto)
                                        : null,
                                    child: widget.complaintCardInfo.userPhoto.isEmpty
                                        ? Icon(Icons.person, size: width * (40 / 1920))
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            // User name
                            Padding(
                              padding: EdgeInsets.only(
                                top: width * (12 / 1920),
                                left: width * (25 / 1920),
                              ),
                              child: Text(
                                widget.complaintCardInfo.userName,
                                style: TextStyle(
                                  fontFamily: 'NunitoSans-Bold',
                                  fontSize: width * (22 / 1920),
                                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                                ),
                              ),
                            ),
                            // Email
                            if (_complaintInfo != null && !_isLoadingDetails)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: width * (20 / 1920),
                                  left: width * (25 / 1920),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      size: width * (20 / 1920),
                                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                                    ),
                                    SizedBox(width: width * (10 / 1920)),
                                    Expanded(
                                      child: Text(
                                        _complaintInfo!.email,
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans-Regular',
                                          fontSize: width * (16 / 1920),
                                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Phone number
                            if (_complaintInfo != null && !_isLoadingDetails)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: width * (12 / 1920),
                                  left: width * (25 / 1920),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: width * (20 / 1920),
                                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                                    ),
                                    SizedBox(width: width * (10 / 1920)),
                                    Text(
                                      _complaintInfo!.phoneNumber,
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans-Regular',
                                        fontSize: width * (16 / 1920),
                                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Loading indicator for details
                            if (_isLoadingDetails)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: width * (25 / 1920),
                                  left: width * (25 / 1920),
                                ),
                                child: SizedBox(
                                  width: width * (25 / 1920),
                                  height: width * (25 / 1920),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      themeProvider.isDarkMode
                                          ? darkPrimaryColor
                                          : primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            // Expanded section
                            if (_isExpanded) ...[
                              Spacer(),
                              // Reply input
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * (15 / 1920),
                                  right: width * (15 / 1920),
                                  bottom: width * (15 / 1920),
                                ),
                                child: TextField(
                                  controller: _replyController,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: width * (16 / 1920),
                                    fontFamily: 'NunitoSans-Light',
                                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: width * (16 / 1920),
                                      horizontal: width * (16 / 1920),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(width * (10 / 1920)),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Write your reply...',
                                    hintStyle: TextStyle(
                                      fontSize: width * (16 / 1920),
                                      color: getHintTextColor(themeProvider.isDarkMode),
                                      fontFamily: 'NunitoSans-Light',
                                    ),
                                    filled: true,
                                    fillColor: getInputBackgroundColor(themeProvider.isDarkMode),
                                  ),
                                ),
                              ),
                              // Submit reply button
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * (15 / 1920),
                                  right: width * (15 / 1920),
                                  bottom: width * (12 / 1920),
                                ),
                                child: Button(
                                  buttonAction: _isSubmittingReply ? null : _submitReply,
                                  widthOfButton: width * (220 / 1920),
                                  heightOfButton: width * (45 / 1920),
                                  borderRadiusOfButton: width * (10 / 1920),
                                  child: _isSubmittingReply
                                      ? SizedBox(
                                          width: width * (24 / 1920),
                                          height: width * (24 / 1920),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              getTextColor(themeProvider.isDarkMode),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Send Reply',
                                          style: TextStyle(
                                            fontFamily: 'NunitoSans-Bold',
                                            fontSize: width * (16 / 1920),
                                            color: getTextColor(themeProvider.isDarkMode),
                                          ),
                                        ),
                                ),
                              ),
                              // Mark as resolved button
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * (15 / 1920),
                                  right: width * (15 / 1920),
                                  bottom: width * (15 / 1920),
                                ),
                                child: Button(
                                  buttonAction: _isResolving ? null : _markAsResolved,
                                  widthOfButton: width * (220 / 1920),
                                  heightOfButton: width * (45 / 1920),
                                  borderRadiusOfButton: width * (10 / 1920),
                                  child: _isResolving
                                      ? SizedBox(
                                          width: width * (24 / 1920),
                                          height: width * (24 / 1920),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              getTextColor(themeProvider.isDarkMode),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Mark as Resolved',
                                          style: TextStyle(
                                            fontFamily: 'NunitoSans-Bold',
                                            fontSize: width * (16 / 1920),
                                            color: getTextColor(themeProvider.isDarkMode),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Divider
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width * (10 / 1920),
                        height: _isExpanded ? width * (580 / 1920) : width * (400 / 1920),
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? darkBackGroundColor
                              : backGroundColor,
                        ),
                      ),
                    ],
                  ),
                  // Right Column - Complaint Details
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width * (620 / 1920),
                        height: _isExpanded ? width * (580 / 1920) : width * (400 / 1920),
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? darkSecondaryColor
                              : secondaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * (12 / 1920)),
                            bottomRight: Radius.circular(width * (12 / 1920)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top row - Complaint type, severity, date, status
                            SizedBox(
                              width: width * (620 / 1920),
                              height: width * (100 / 1920),
                              child: Row(
                                children: [
                                  // Complaint type
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: width * (12 / 1920),
                                        left: width * (12 / 1920),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * (12 / 1920),
                                        vertical: width * (10 / 1920),
                                      ),
                                      decoration: BoxDecoration(
                                        color: themeProvider.isDarkMode
                                            ? darkPrimaryColor
                                            : primaryColor,
                                        borderRadius: BorderRadius.circular(width * (10 / 1920)),
                                      ),
                                      child: Text(
                                        widget.complaintCardInfo.name,
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans-Bold',
                                          fontSize: width * (16 / 1920),
                                          color: getTextColor(themeProvider.isDarkMode),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Severity
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: width * (12 / 1920),
                                        left: width * (8 / 1920),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * (10 / 1920),
                                        vertical: width * (8 / 1920),
                                      ),
                                      decoration: BoxDecoration(
                                        color: widget.complaintCardInfo.severity.toLowerCase() == 'critical'
                                            ? (themeProvider.isDarkMode
                                                ? darkSixthColorPrimaryRed
                                                : sixthColorPrimaryRed)
                                            : (themeProvider.isDarkMode
                                                ? darkFourthColorPrimaryBrown
                                                : fourthColorPrimaryBrown),
                                        borderRadius: BorderRadius.circular(width * (10 / 1920)),
                                      ),
                                      child: Text(
                                        widget.complaintCardInfo.severity.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans-Bold',
                                          fontSize: width * (14 / 1920),
                                          color: getTextColor(themeProvider.isDarkMode),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Date and status
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: width * (12 / 1920),
                                          ),
                                          child: Text(
                                            _formatDate(widget.complaintCardInfo.createdAt),
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans-Regular',
                                              fontSize: width * (16 / 1920),
                                              color: getPrimaryTextColor(themeProvider.isDarkMode),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: width * (12 / 1920),
                                          ),
                                          child: Text(
                                        widget.complaintCardInfo.complaintStatus,
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans-Bold',
                                              fontSize: width * (16 / 1920),
                                              color: widget.complaintCardInfo.complaintStatus.toLowerCase() == 'pending'
                                                  ? (themeProvider.isDarkMode
                                                      ? darkFourthColorPrimaryBrown
                                                      : fourthColorPrimaryBrown)
                                                  : (themeProvider.isDarkMode
                                                      ? darkFifthColorPrimaryGreen
                                                      : fifthColorPrimaryGreen),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Issue message
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * (25 / 1920),
                                  vertical: width * (20 / 1920),
                                ),
                                child: _isLoadingDetails
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            themeProvider.isDarkMode
                                                ? darkPrimaryColor
                                                : primaryColor,
                                          ),
                                        ),
                                      )
                                    : _complaintInfo != null
                                        ? SingleChildScrollView(
                                            child: Text(
                                              _complaintInfo!.issueMessage,
                                              style: TextStyle(
                                                fontFamily: 'NunitoSans-Regular',
                                                fontSize: width * (18 / 1920),
                                                color: getPrimaryTextColor(themeProvider.isDarkMode),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Failed to load complaint details',
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans-Regular',
                                              fontSize: width * (16 / 1920),
                                              color: getPrimaryTextColor(themeProvider.isDarkMode),
                                            ),
                                          ),
                              ),
                            ),
                            // Expand/Collapse button
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * (25 / 1920),
                                right: width * (25 / 1920),
                                bottom: width * (20 / 1920),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * (20 / 1920),
                                    vertical: width * (12 / 1920),
                                  ),
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode
                                        ? darkBackGroundColor
                                        : backGroundColor,
                                    borderRadius: BorderRadius.circular(width * (10 / 1920)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _isExpanded ? 'Collapse' : 'Expand',
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans-Bold',
                                          fontSize: width * (16 / 1920),
                                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                                        ),
                                      ),
                                      SizedBox(width: width * (10 / 1920)),
                                      Icon(
                                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                                        size: width * (20 / 1920),
                                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}