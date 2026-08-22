import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/contact_support_button/models/complaint_type_model.dart';
import 'package:untitled1/core/widgets/contact_support_button/services/create_complaint.dart';
import 'package:untitled1/core/widgets/contact_support_button/services/get_all_complaint_types.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ContactSupportDialog extends StatefulWidget {
  const ContactSupportDialog({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<ContactSupportDialog> createState() => _ContactSupportDialogState();
}

class _ContactSupportDialogState extends State<ContactSupportDialog> {
  List<ComplaintTypeModel> _complaintTypes = [];
  ComplaintTypeModel? _selectedComplaintType;
  final TextEditingController _complaintDescriptionController =
      TextEditingController();
  bool _isLoadingComplaintTypes = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  Future<void> _getComplaintTypes() async {
    setState(() {
      _isLoadingComplaintTypes = true;
      _errorMessage = null;
    });

    try {
      List<ComplaintTypeModel> complaintTypes = await getAllComplaintTypes();
      if (mounted) {
        setState(() {
          _complaintTypes = complaintTypes;
          _isLoadingComplaintTypes = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingComplaintTypes = false;
          _errorMessage = 'Failed to load complaint types. Please try again.';
        });
      }
    }
  }

  Future<void> _submitComplaint() async {
    if (_selectedComplaintType == null) {
      _showSnackBar('Please select a complaint type');
      return;
    }

    if (_complaintDescriptionController.text.trim().isEmpty) {
      _showSnackBar('Please enter a complaint description');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      await createComplaint(
        dioClient: dioClient,
        complaintTypeId: _selectedComplaintType!.complaintTypeId,
        issueMessage: _complaintDescriptionController.text.trim(),
      );

      if (!mounted) return;

      _showSnackBar('Complaint submitted successfully');
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      _showSnackBar('Failed to submit complaint: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    _getComplaintTypes();
    super.initState();
  }

  @override
  void dispose() {
    _complaintDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      constraints: BoxConstraints(
        maxWidth: width * (750 / 1920),
        maxHeight: width * (570 / 1920),
      ),
      child: Container(
        width: width * (750 / 1920),
        height: width * (570 / 1920),
        padding: EdgeInsets.all(width * (25 / 1920)),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(width * (15 / 1920)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send Complaint',
                style: TextStyle(
                  fontSize: width * (32 / 1920),
                  fontFamily: 'NunitoSans-Bold',
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                ),
              ),

              SizedBox(height: width * (20 / 1920)),

              // Complaint Type Dropdown
              Text(
                'What is the type of your Complaint:',
                style: TextStyle(
                  fontSize: width * (20 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                ),
              ),

              SizedBox(height: width * (10 / 1920)),

              if (_isLoadingComplaintTypes)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(width * (20 / 1920)),
                    child: CircularProgressIndicator(
                      color: themeProvider.isDarkMode
                          ? darkPrimaryColor
                          : primaryColor,
                    ),
                  ),
                )
              else if (_errorMessage != null)
                Container(
                  padding: EdgeInsets.all(width * (15 / 1920)),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? darkSixthColorPrimaryRed
                        : sixthColorPrimaryRed,
                    borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                        size: width * (24 / 1920),
                      ),
                      SizedBox(width: width * (10 / 1920)),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            fontSize: width * (16 / 1920),
                            fontFamily: 'NunitoSans-Medium',
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                          size: width * (20 / 1920),
                        ),
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                          });
                          _getComplaintTypes();
                        },
                      ),
                    ],
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * (20 / 1920),
                    vertical: width * (5 / 1920),
                  ),
                  decoration: BoxDecoration(
                    color: getInputBackgroundColor(themeProvider.isDarkMode),
                    borderRadius: BorderRadius.circular(width * (15 / 1920)),
                    border: Border.all(
                      color: getBorderColor(themeProvider.isDarkMode),
                      width: width * (1 / 1920),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ComplaintTypeModel>(
                      value: _selectedComplaintType,
                      isExpanded: true,
                      hint: Text(
                        'Select complaint type',
                        style: TextStyle(
                          fontSize: width * (18 / 1920),
                          fontFamily: 'NunitoSans-Medium',
                          color: getHintTextColor(themeProvider.isDarkMode),
                        ),
                      ),
                      style: TextStyle(
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-Medium',
                        fontSize: width * (18 / 1920),
                      ),
                      dropdownColor: themeProvider.isDarkMode
                          ? darkCardColor
                          : lightCardColor,
                      items: _complaintTypes.map((complaintType) {
                        return DropdownMenuItem<ComplaintTypeModel>(
                          value: complaintType,
                          child: Text(
                            complaintType.complaintIssueMessage,
                            style: TextStyle(
                              color: getPrimaryTextColor(
                                themeProvider.isDarkMode,
                              ),
                              fontFamily: 'NunitoSans-Medium',
                              fontSize: width * (18 / 1920),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedComplaintType = value;
                        });
                      },
                    ),
                  ),
                ),

              SizedBox(height: width * (20 / 1920)),

              // Complaint Description
              Text(
                'Description about your problem:',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                ),
              ),

              SizedBox(height: width * (10 / 1920)),

              CustomTextField(
                onChanged: (value) {},
                hintText: 'Enter your complaint description...',
                widthOfTextField: 700,
                fillColor: getInputBackgroundColor(themeProvider.isDarkMode),
                fontSize: 18,
                fontFamily: FontFamily.light,
                controller: _complaintDescriptionController,
                maxLines: 5,
              ),

              SizedBox(height: width * (40 / 1920)),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWithText(
                    widthOfButton: width * (150 / 1920),
                    heightOfButton: width * (40 / 1920),
                    text: 'Cancel',
                    buttonAction: () {
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(width: width * (20 / 1920)),

                  ButtonWithText(
                    widthOfButton: width * (150 / 1920),
                    heightOfButton: width * (40 / 1920),
                    text: _isSubmitting ? 'Submitting...' : 'Confirm',
                    buttonAction: _isSubmitting ? null : _submitComplaint,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
